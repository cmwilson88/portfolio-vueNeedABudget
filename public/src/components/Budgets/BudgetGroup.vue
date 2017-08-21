<template>
	<div>
		<app-budget-main-row :budgetgroup="group.budgetgroup"></app-budget-main-row>
		<app-budget-spend-row 
			v-for="spendcategory in group.budgetgroup.subcategories"
			:spendcategory="spendcategory"
			key="spendcategory.id"></app-budget-spend-row>
	</div>
</template>

<script>
	import BudgetSpendCategoryRow from './BudgetSpendCategoryRow.vue'
	import BudgetMainCategoryRow from './BudgetMainCategoryRow.vue'
	export default {
		props: ['group'],
		components: {
			appBudgetMainRow: BudgetMainCategoryRow,
			appBudgetSpendRow: BudgetSpendCategoryRow
		}
	}
</script>

<style>
	.greentext {
		color: green;
	},
	.available_pos {
		color: #fff;
		font-weight: 700;
		padding: 2px 8px;
		border-radius: 1000px;
		background-color: #16a336;
	},
	.available_amount {
		color: #fff;
		font-weight: 700;
		padding: 2px 8px;
		border-radius: 1000px;
	},
	.spend_cat_budgeted input {
		border: 2px solid #23809b;
		border-radius: 7px;
	}
</style>