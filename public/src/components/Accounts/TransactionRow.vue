<template>
	<div class="account_grid_body_row">
		<!-- <div class="account_grid_body_row"> -->
			<div class="account_grid_cell account_grid_cell_checkbox" @click="editModal = true"><i class="icon edit"></i></div>
			<div class="account_grid_cell account_grid_cell_notification"></div>
			<div class="account_grid_cell account_grid_cell_flag"></div>
			<div class="account_grid_cell account_grid_cell_accountName">{{transaction.account | capitalize-words}}</div>
			<div class="account_grid_cell account_grid_cell_date">{{transaction.date}}</div>
			<div class="account_grid_cell account_grid_cell_payeeName">{{transaction.payee}}</div>
			<div class="account_grid_cell account_grid_cell_subCategoryName">{{transaction.category}}</div>
			<div class="account_grid_cell account_grid_cell_memo">{{transaction.memo}}</div>
			<div class="account_grid_cell account_grid_cell_outflow">${{this.transaction.outflow * -1 | amount-with-comma}}</div>
			<div v-if="transaction.inflow" class="account_grid_cell account_grid_cell_inflow">${{transaction.inflow | amount-with-comma}}</div>
			<div class="account_grid_cell account_grid_cell_cleared">
				<div class="centerContent">
					<div class="clearedCircle" :class="{green: transaction.cleared}" v-on:click="triggerClearUnclear"></div>
				</div>
			</div>
		<!-- </div> -->

		<app-input-modal v-if="editModal" @close="editModal = false">
			<h3 slot="header">Edit Transaction</h3>
			<div class="modal_inputs">
				<label for="account">Account:</label>
				<select name="account" v-model="editTransaction.account">
					<option 
						v-for="account in accounts"
						:value="account.id"
						key="account.id">{{account.name}}</option>
				</select>
				<br>
				<label for="date">Date:</label>
				<input type="date" v-model="editTransaction.date">
				<br>
				<select name="payees" v-model="editTransaction.payee">
					<option selected disabled>Select a Payee</option>
					<option 
						v-for="payee in payees"
						:value="payee.id"
						key="payee.id">{{payee.name}}</option>
				</select>
				<div class="payee_button_container">
					<button class="add_payee_button" @click="addPayeeStatus = true">
						<i class="icon add circle"></i>
						Add Payee
					</button>
				</div>
				<br>
				<label for="category">Category:</label>
				<select name="categories" v-model="editTransaction.category">
					<option selected disabled>Select a Category</option>
					<optgroup 
						v-for="item in categories"
						:label="item.budgetgroup.name">
							<option
								v-for="category in item.budgetgroup.subcategories"
								:value="category">{{category.name}}</option>
					</optgroup>
				</select>
				<br>
				<label for="memo">Memo:</label>
				<input type="text" v-model="editTransaction.memo">
				<br>
				<label for="outflow">Outflow:</label>
				<input type="number" v-model="editTransaction.outflow">
				<br>
				<label for="inflow">Inflow:</label>
				<input type="number" v-model="editTransaction.inflow">
				<br>
			</div>
			<div slot="footer"class="modal_edit_buttons">
				<button @click="updateTransaction">Save</button>
				<button @click="editModal=false">Cancel</button>
				<button @click="deleteTransaction">Delete</button>
			</div>
		</app-input-modal>


		<app-input-modal v-if="addPayeeStatus" @close="addPayeeStatus = false" @submit="addNewPayee">
			<h3 slot="header">Add Payee</h3>
			<div class="modal_inputs">
				<label>Add New Payee:</label>
				<input type="text" v-model="newPayee.name">
			</div>
		</app-input-modal>
	</div>
</template>

<script>
	import axios from 'axios'
	import {mapActions} from 'vuex'
	import InputModal from '../InputModals/InputModal.vue'
	export default {
		props: ['transaction'],
		data() {
			return {
				addPayeeStatus: false,
				cleared: this.transaction.cleared,
				editModal: false,
				editTransaction: {
					account: this.transaction.account,
					date: this.transaction.date,
					payee: this.transaction.payee.name,
					category: this.transaction.category,
					memo: this.transaction.memo,
					inflow: this.transaction.inflow,
					outflow: this.transaction.outflow * -1,
					type: this.transaction.type,
					month: this.transaction.month,
					year: this.transaction.year,
					catgroup_act_id: this.transaction.catgroup_act_id
				},
				newPayee: {
					name: ''
				}
			}
		},
		computed: {
			accounts: function() {
				return this.$store.state.accounts
			},
			payees: function() {
				return this.$store.state.payees
			},
			categories: function() {
				return this.$store.state.categories
			}
		},
		methods: {
			...mapActions(['getTransactions', 'getAccounts', 'getBudgetCategories']),
			addNewPayee() {
				axios.post('/api/' + this.$route.params.b_id + '/payees/new', 
					{
						name: this.newPayee.name 
					}
				).then(response => {
					console.log('new payee added')
					this.getPayees();
					this.addPayeeStatus = false
				})
			},
			deleteTransaction() {
				axios.delete('/api/'+ this.$route.params.b_id +'/transactions/' + this.transaction.id + '/' + this.transaction.spend_cat_id + '/' + this.transaction.trans_month + '/' + this.transaction.trans_year + '/' + this.transaction.catgroup_act_id + '/' + this.transaction.catgroup_id
				).then(() => {
						this.getTransactions();
						this.getAccounts();
						this.editModal = false;
					})
			},
			updateTransaction() {
				let month = this.editTransaction.date.split('-')[1];
				let year = this.editTransaction.date.split('-')[0];
				if(this.editTransaction.category.type === 'inflow') {
							axios.patch('/api/'+this.$route.params.b_id+'/transactions/' + this.transaction.id + '/inflow', {
							account: this.editTransaction.account,
							date: this.editTransaction.date,
							payee: this.editTransaction.payee,
							category: this.editTransaction.category.id,
							memo: this.editTransaction.memo,
							outflow: Number(this.editTransaction.outflow) * -1,
							inflow: Number(this.editTransaction.inflow),
							type: this.editTransaction.category.type,
							month: month,
							year: year,
							catgroup_act_id: this.transaction.catgroup_act_id,
							catgroup_id: this.transaction.catgroup_id
						})
						.then(() => {
							console.log('transaction updated')
							this.getTransactions();
							this.getAccounts();
							this.editModal = false;
						})
				} else {
					axios.patch('/api/'+this.$route.params.b_id+'/transactions/' + this.transaction.id, {
							account: this.editTransaction.account,
							date: this.editTransaction.date,
							payee: this.editTransaction.payee,
							category: this.editTransaction.category.id,
							memo: this.editTransaction.memo,
							outflow: Number(this.editTransaction.outflow) * -1,
							inflow: Number(this.editTransaction.inflow),
							type: this.editTransaction.category.type,
							month: month,
							year: year,
							catgroup_act_id: this.transaction.catgroup_act_id,
							catgroup_id: this.transaction.catgroup_id
						})
						.then(() => {
							console.log('transaction updated')
							this.getTransactions();
							this.getAccounts();
							this.editModal = false;
						})
				}
			},
			triggerClearUnclear() {
				axios.patch('/api/transactions/' + this.transaction.id, {
					cleared: !this.cleared
				}).then(() => {
					this.cleared = !this.cleared
					this.getTransactions();
				})
			}
		},
		components: {
			appInputModal: InputModal
		}
	}
</script>

<style>
	.centerContent {
		height: 100%;
		width: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.clearedCircle {
		height: 17px;
		width: 17px;
		border-radius: 100%;
		background-color: #888;
	}

	.green {
		background-color: green;
	}
</style>
