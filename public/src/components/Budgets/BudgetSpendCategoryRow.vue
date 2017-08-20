<template>
	<div>
		<ul class="budget_table_row spend_cat" @contextmenu.prevent="editModal = true">
			<li class="spend_cat_name">{{spendcategory.name}}</li> 
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
				${{spendcategory.available.toFixed(2) | amount-with-comma }}
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
		methods: {
			...mapActions(['getBudgetCategories', 'getToBeBudgeted']),
			deleteSpendCat() {
				axios.delete('http://localhost:3000/api/spendcats/' + this.id)
				.then(() => {
					this.getBudgetCategories();
					this.editModal = false
				})
			},
			updateSpendCat() {
				axios.patch('http://localhost:3000/api/spendcats/' + this.id, {name: this.spendCatName})
					.then(() => {
						this.getBudgetCategories();
						this.spendCatName = ''
						this.editModal = false
					})
			},
			updatedBudgetedAmount() {
				if(this.budgetedValue !== this.spendcategory.amount) {
					axios.patch('http://localhost:3000/api/'+this.$route.params.b_id+'/spendcats/' + this.id, {
						amount: this.budgetedValue
					})
						.then(() => {
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
	.spend_cat_budgeted input {
		border: 2px solid #23809b;
		border-radius: 7px;
	}
</style>