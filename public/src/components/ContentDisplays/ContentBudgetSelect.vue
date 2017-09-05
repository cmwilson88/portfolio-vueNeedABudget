<template>
	<div class="select_budget_wrapper">
		<h1 class="bselect_header">Select a Budget</h1>
		<app-input-modal v-if="addBudgetStatus" @close="addBudgetStatus = false" @submit="addNewBudget">
			<h3 slot="header">Add New Budget</h3>
			<div class="modal_inputs">
				<label>Budget Name:</label>
				<input type="text" v-model="newBudget.name">
			</div>
		</app-input-modal>
		<div class="bselect_btn_wrapper">
			<app-select-budget-button
				v-for="budget in userBudgets"
				:budget="budget"
				:month="month"
				:year="year"
				:key="budget.id" 
				>
			</app-select-budget-button>
			<div class="budget_select_div add_budget_btn" @click="addBudgetStatus = true">Add Budget</div>
		</div>
	</div>
</template>

<script>
	import axios from 'axios'
	import {mapGetters, mapActions} from 'vuex'
	import InputModal from '../InputModals/InputModal.vue'
	import SelectBudgetButton from './SelectBudgetButton.vue'
	export default {
		data() {
			return {
				addBudgetStatus: false,
				newBudget: {
					name: ''
				}
			}
		},
		computed: {
			...mapGetters(['month', 'year']),
			userBudgets() {
				return this.$store.state.userBudgets
			}
		},
		methods: {
			...mapActions(['getToday', 'getUserBudgets']),
			addNewBudget() {
				return axios.post('/api/budgets/new', {
					name: this.newBudget.name,
					month: this.month,
					year: this.year
				}).then(() => {
					this.getUserBudgets();
					this.addBudgetStatus = false;
					this.newBudget.name = '';
				})
			}
		},
		components: {
			appInputModal: InputModal,
			appSelectBudgetButton: SelectBudgetButton
		},
		created() {
			this.getToday();
			this.getUserBudgets();
		}
	}
</script>

<style>
	.select_budget_wrapper {
		display: flex;
		flex-direction: column;
		align-items: center;

		width: 100%;
	}
	.bselect_header {
		margin-top: 50px;
		font-weight: 900;
		font-size: 2em;
	}
	.bselect_btn_wrapper {
		display: flex;
		margin-top: 50px;
	}
	.budget_select_div {
		display: flex;
		justify-content: center;
		align-items: center;
		width: 150px;
		height: 150px;
		border: 15px solid lightblue;
		margin: 10px;
	}

	.add_budget_btn {
		border: solid 15px lightgreen;
	}
</style>