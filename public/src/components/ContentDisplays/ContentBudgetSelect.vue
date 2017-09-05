<template>
	<div>
		<h1>Select a Budget</h1>
		<p>This is where the user will select their desired budget</p>
		<app-input-modal v-if="addBudgetStatus" @close="addBudgetStatus = false" @submit="addNewBudget">
			<h3 slot="header">Add New Budget</h3>
			<div class="modal_inputs">
				<label>Budget Name:</label>
				<input type="text" v-model="newBudget.name">
			</div>
		</app-input-modal>
		<app-select-budget-button
			v-for="budget in userBudgets"
			:budget="budget"
			:month="month"
			:year="year"
			:key="budget.id" 
			>
		</app-select-budget-button>
		<div class="budget_select_div" @click="addBudgetStatus = true">Add Budget</div>
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
			// goToBudget() {
			// 	this.$router.push('/app/budget/'+ this. +'/' + this.month + '/' + this.year)
			// },
			addNewBudget() {
				return axios.post('/api/budgets/new', {
					name: this.newBudget.name,
					month: this.month,
					year: this.year
				}).then(() => {
					console.log('added new budget')
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

</style>