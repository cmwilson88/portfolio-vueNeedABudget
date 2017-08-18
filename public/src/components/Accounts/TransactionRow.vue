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
				<input type="checkbox" v-on:change="triggerClearUnclear">
			</div>
		<!-- </div> -->

		<app-input-modal v-if="editModal" @close="editModal = false">
			<h3 slot="header">Edit Transaction</h3>
			<div class="modal_inputs">
				<label for="account">Account:</label>
				<select name="account" v-model="transaction.account">
					<option 
						v-for="account in accounts"
						:value="account.id"
						key="account.id">{{account.name}}</option>
				</select>
				<br>
				<label for="date">Date:</label>
				<input type="date" v-model="transaction.date">
				<br>
				<label for="payee">Payee:</label>
				<input name="payees" v-model="transaction.payee">
				<br>
				<label for="category">Category:</label>
				<input name="categories" v-model="transaction.category">
				<br>
				<label for="memo">Memo:</label>
				<input type="text" v-model="transaction.memo">
				<br>
				<label for="outflow">Outflow:</label>
				<input type="number" v-model="transaction.outflow">
				<br>
				<label for="inflow">Inflow:</label>
				<input type="number" v-model="transaction.inflow">
				<br>
			</div>
			<div slot="footer"class="modal_edit_buttons">
				<button>Save</button>
				<button @click="editModal=false">Cancel</button>
				<button @click="deleteTransaction">Delete</button>
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
				accounts: [
					{id: 1, name: 'USAA Checking'},
					{id: 2, name: 'USAA Savings'},
					{id: 3, name: 'USAA Visa Credit Card'}
				],
				categories: [
					{id: 1, name: 'Rent/Mortgage'},
					{id: 2, name: 'Electric'},
					{id: 3, name: 'Water'}
				],
				payees: [
					{id: 1, name: 'DevMountain'},
					{id: 2, name: 'Electric'},
					{id: 3, name: 'Smiths'}
				],
				cleared: false,
				editModal: false,
				editTransaction: {
					name: this.transaction.name,
					date: this.transaction.date,
					payee: this.transaction.payee,
					category: this.transaction.category,
					memo: this.transaction.memo,
					inflow: this.transaction.inflow,
					outflow: this.transaction.outflow
				}
			}
		},
		methods: {
			...mapActions(['getTransactions', 'getAccounts']),
			deleteTransaction() {
				axios.delete('http://localhost:3000/api/transactions/' + this.transaction.id)
					.then(() => {
						this.getTransactions();
						this.getAccounts();
						this.editModal = false;
					})
			},
			triggerClearUnclear() {
				if(!this.cleared) {
					axios.patch('http://localhost:3000/api/transactions/' + this.transaction.id, {
						cleared: true
					}).then(() => {
						this.cleared = true
					})
				} else {
					axios.patch('http://localhost:3000/api/transactions' + this.transaction.id, {
						cleared: false
					}).then(() => {
						this.cleared = false
					})
				}
			}
		},
		components: {
			appInputModal: InputModal
		}
	}
</script>
