<template>
	<div class="layout">
		<div class="layout_sidebar">
			<h2>Wilson Budget</h2>
			<app-budget-nav></app-budget-nav>
			<hr>
			<app-main-accounts-list></app-main-accounts-list>
		</div>
		<div class="layout_content">
			<app-display-budget></app-display-budget>
		</div>
	</div>
</template>

<script>
	import DisplayBudget from '../Budgets/DisplayBudget.vue'
	import MainAccountsList from '../Accounts/MainAccountsList.vue'
	import BudgetNav from '../Budgets/BudgetNav.vue'
	export default {
		data() {
			return {

			}
		},
		components: {
			appDisplayBudget: DisplayBudget,
			appMainAccountsList: MainAccountsList,
			appBudgetNav: BudgetNav
		}
	}
</script>

<style>
	.layout {
		display: flex;
	}

	.layout_sidebar {
		position: fixed;
		top: 0;
		bottom: 0;
		z-index: 999;
		width: 260px;
		height: 100%;
		background: linear-gradient(to bottom, #34aebe, #23809b);
		color: #fff;
	}

	.layout_content {
		position: fixed;
		padding: 0;
		top: 0;
		right: 0;
		bottom: 0;
		left: 260px;

		display: inline-block;
    	zoom: 1;
    	letter-spacing: normal;
    	word-spacing: normal;
    	vertical-align: top;
    	text-rendering: auto;

	}

	@media(max-width: 1100px) {
		.layout_content {
			overflow-x: auto;
			overflow-y: hidden;
		}
	}
</style>