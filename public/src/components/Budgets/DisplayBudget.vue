<template>
	<div class="budget_view_main">
		<div class="budget_view_sidebar">
			<h2>Wilson Budget</h2>
			<app-budget-nav></app-budget-nav>
			<hr>
			<app-main-accounts-list></app-main-accounts-list>
		</div>
		<div class="budget_view_content">
			<app-budget-view-header></app-budget-view-header>
			<div class="bv_category_transactions">
				<router-view></router-view>
			</div>
		</div>
	</div>
</template>

<script>
	import BudgetViewHeader from '../Headers/BudgetViewHeader.vue'
	import MainAccountsList from '../Accounts/MainAccountsList.vue'
	import BudgetNav from './BudgetNav.vue'
	export default {
		data() {
			return {

			}
		},
		components: {
			appBudgetViewHeader: BudgetViewHeader,
			appMainAccountsList: MainAccountsList,
			appBudgetNav: BudgetNav
		}
	}
</script>

<style>
	.budget_view_main {
		display: flex;
	}

	.budget_view_sidebar {
		position: fixed;
		top: 0;
		bottom: 0;
		z-index: 999;
		width: 260px;
		height: 100%;
		background: linear-gradient(to bottom, #34aebe, #23809b);
		color: #fff;
	}

	.budget_view_content {
		position: fixed;
		padding: 0;
		top: 0;
		right: 0;
		bottom: 0;
		left: 260px;
	}

	.bv_category_transactions {
		width: 100%;
	    min-width: 562px;
	    position: absolute;
	    left: 0;
	    top: 5em;
	    bottom: 0;
	    display: block;
	    overflow: auto;
	    z-index: 8;
	    background: #efeff4;
	}
</style>