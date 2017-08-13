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