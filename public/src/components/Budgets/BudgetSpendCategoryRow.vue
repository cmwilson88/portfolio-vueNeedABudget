<template>
	<div>
		<ul class="budget_table_row spend_cat" @contextmenu.prevent="editModal = true">
			<li class="spend_cat_name">{{spendcategory.name | capitalize-words}}</li> 
			<li 
				@mouseenter="hoverBudgetInput = true"
				@mouseleave="hoverBudgetInput = false"
				class="spend_cat_budgeted">
					<span v-if="!hoverBudgetInput && !editBudgetInput">
						${{spendcategory.budgeted.toFixed(2) | amount-with-comma }}
					</span>
					<input 
						@focus="editBudgetInput=true" 
						@blur="resetInputData"
						@keyup.esc="editBudgetInput=false"
						@keyup.enter="updatedBudgetedAmount"
						v-model="budgetedValue" 
						type="text" 
						style="text-align: right"
						v-else> 
			</li>

			<li class="spend_cat_activity">
				${{spendcategory.activity.toFixed(2) | amount-with-comma }}
			</li>
			<li class="spend_cat_available">
				<span class="available_amount" :class="{'available_zero': checkZero, 'available_pos': checkPositive, 'available_neg': checkNegative}">
					${{spendcategory.available.toFixed(2) | amount-with-comma }}
				</span>
			</li>
		</ul>
		<app-input-modal v-if="editModal" @close="editModal = false">
			<h3 slot="header">Edit Spending Category</h3>
			<div class="modal_inputs">
				<label>Spending Category Name:</label>
				<input type="text" v-model="spendCatName">
			</div>
			<div slot="footer"class="modal_edit_buttons">
				<button @click="updateSpendCat">Save</button>
				<button @click="editModal=false">Cancel</button>
				<button @click="deleteSpendCat">Delete</button>
			</div>
		</app-input-modal>
	</div>
</template>

<script>
	import axios from 'axios'
	import {mapActions} from 'vuex'
	import InputModal from '../InputModals/InputModal.vue'
	export default {
		props: ['spendcategory'],
		data() {
			return {
				editModal: false,
				hoverBudgetInput: false,
				editBudgetInput: false,
				budgetedValue: null,
				id: this.spendcategory.id,
				spendCatName: this.spendcategory.name
			}
		},
		computed: {
			checkNegative() {
				if(this.spendcategory.available < 0) {
					return true
				} else {
					return false
				}
			},
			checkPositive() {
				if(this.spendcategory.available > 0) {
					return true
				} else {
					return false
				}
			},
			checkZero() {
				if(!this.spendcategory.available) {
					return true
				} else {
					return false
				}
			}
		},
		methods: {
			...mapActions(['getBudgetCategories', 'getToBeBudgeted']),
			deleteSpendCat() {
				axios.delete('/api/spendcats/' + this.id)
				.then(() => {
					this.getBudgetCategories();
					this.editModal = false
				})
			},
			updateSpendCat() {
				axios.patch('/api/spendcats/' + this.id, {name: this.spendCatName})
					.then(() => {
						this.getBudgetCategories();
						this.spendCatName = ''
						this.editModal = false
					})
			},
			updatedBudgetedAmount() {
				if(this.budgetedValue !== this.spendcategory.amount) {
					axios.patch('/api/'+this.$route.params.b_id+'/spendcats/' + this.id + '/' + this.$route.params.mm + '/' + this.$route.params.yy, {
						amount: this.budgetedValue,
						catgroup_id: this.spendcategory.catgroup_id,
						catgroup_act_id: this.spendcategory.catgroup_act_id
					})
						.then(() => {
							console.log('budgeted amount updated')
							this.getBudgetCategories();
							this.getToBeBudgeted();
							this.resetInputData();
						})
				}
			},
			resetInputData() {
				this.editBudgetInput = false;
				this.budgetedValue = null;
				this.hoverBudgetInput=false;
			}
		},
		components: {
			appInputModal: InputModal
		}
	}
</script>

<style>
	.greentext {
		color: green;
	}
	.available_pos {
		background-color: #16a336;
	}
	.available_neg {
		background-color: #D33C2D;
	}
	.available_zero {
		background-color: #a8a8a8
	}
	.available_amount {
		color: #fff;
		font-weight: 700;
		padding: 2px 8px;
		border-radius: 1000px;
	}
	.spend_cat_budgeted input {
		border: 2px solid #23809b;
		border-radius: 7px;
	}

</style>