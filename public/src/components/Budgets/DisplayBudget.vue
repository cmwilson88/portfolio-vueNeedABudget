<template>
	<div class="scroll_wrap">
		<app-budget-view-header></app-budget-view-header>
		<router-view></router-view>
		<app-budget-inspector></app-budget-inspector>
	</div>
</template>

<script>
	import BudgetInspector from '../Budgets/BudgetInspector.vue'
	import BudgetViewHeader from '../Headers/BudgetViewHeader.vue'
	export default {
		data() {
			return {

			}
		},
		components: {
			appBudgetViewHeader: BudgetViewHeader,
			appBudgetInspector: BudgetInspector
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