<template>
	<div class="scroll_wrap">
		<app-budget-header></app-budget-header>
		<app-budget-category-list></app-budget-category-list>
		<app-budget-inspector></app-budget-inspector>
	</div>
</template>

<script>
	import BudgetInspector from '../Budgets/BudgetInspector/BudgetInspector.vue'
	import BudgetHeader from '../Headers/BudgetHeader.vue'
	import MainCategoryList from '../Categories/MainCategoryList.vue'
	import {mapActions} from 'vuex'
	export default {
		methods: {
			...mapActions(['getToBeBudgeted', 'getToday'])
		},
		components: {
			appBudgetHeader: BudgetHeader,
			appBudgetCategoryList: MainCategoryList,
			appBudgetInspector: BudgetInspector
		},
		created() {
			console.log('get today')
			this.getToBeBudgeted();
			this.getToday();
		}
	}
</script>

<style>
	@media(max-width: 1100px) {
		.scroll_wrap {
			width: 838px;
		}
	}
</style>