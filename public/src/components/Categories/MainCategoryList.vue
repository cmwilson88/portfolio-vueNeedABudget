<template>
	<div class="budget_content">
		<ul class="budget_table_header">
			<li class="budget_table_cell_name">CATEGORY</li>
			<li class="budget_table_cell_budgeted">BUDGETED</li>
			<li class="budget_table_cell_activity">ACTIVITY</li>
			<li class="budget_table_cell_available">AVAILABLE</li>
		</ul>
		<div class="budget_table">
			<app-budget-group
				v-for="group in budgetCategories"
				:group="group"
				key="group.budgetgroup.id"></app-budget-group>
		</div>
	</div>
</template>

<script>
	import BudgetGroup from '../Budgets/BudgetGroup.vue'
	import {mapGetters, mapActions} from 'vuex'
	export default {
		computed: {
			...mapGetters(['budgetCategories'])
		},
		watch: {
			month() {
				return this.$route.params.mm
			}
		},
		methods: {
			...mapActions(['getBudgetCategories'])
		},
		components: {
			appBudgetGroup: BudgetGroup
		},
		created() {
			this.getBudgetCategories()
		},
		destroyed() {
			console.log('main list destroyed')
		}
	}
</script>

<style>
	.budget_content {
		width: 67%;
		min-width: 562px;
		position: absolute;
		left: 0;
		top: 8em;
		bottom: 0;
		display: block;
		overflow: auto;
		z-index: 8;

		background-color: #efeff4;
	}

	.budget_content ul {
		width: 100%;
		height: 2.3em;
		margin: 0;
		padding: 0;
		padding-right: 1%;
		color: #333;
		font-size: .875em;
		overflow: hidden;
		zoom: 1;
	}

	.budget_content li {
		height: 100%;
		list-style: none;
		margin: 0;
		padding: 0;
		float: left;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}

	.budget_table_header {
		background-color: #fff;
		border-bottom: 1px solid #dee3e8;
		height: 1.75em !important;

		min-width: 562px;
		display: block;
	}

	.budget_table_header li {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: flex-end;
		font-weight: normal;
		color: #4c7079;
	}

	.budget_table_header .budget_table_cell_name {
		flex-direction: row;
		align-items: center;
		justify-content: flex-start;
		padding-left: 1% !important;
		text-align: left;
		width: 47%;
	}

	.budget_table {
		width: 100%;
		min-width: 562px;
		display: block;
		overflow: auto;
	}

	.category_group,
	.spend_cat {
		display: flex;
		align-items: center;
		width: 100%;
	}
	
	.category_group {
		background-color: #e5f5f9;
		border-top: 1px solid #dee3e8;
		margin-top: -1px;
	}

	.spend_cat {
		border-top: 1px solid #dee3e8;
		background-color: #fff;
	}
	
	.category_group_name {
		display: flex;
		align-items: center;
		font-size: 1.125em;
		padding-top: .125em;
		padding-left: 1% !important;
		color: #003440;
		width: 47%;
	}

	.spend_cat_name {
		display: flex;
		align-items: center;
		text-align: left;
		width: 47%;
		padding-left: 1% !important;
	}

	.category_group_budgeted,
	.category_group_activity,
	.category_group_available {
		color: #588697;
		
	}
	.budget_table_cell_budgeted,
	.budget_table_cell_activity,
	.budget_table_cell_available,
	.category_group_budgeted,
	.category_group_activity,
	.category_group_available,
	.spend_cat_budgeted,
	.spend_cat_activity,
	.spend_cat_available {
		line-height: 2.5;
		text-align: right;
		width: 15%;
		font-size:.9285em;
	}
	
	.budget_table_cell_available,
	.category_group_available,
	.spend_cat_available {
		width: 20%;
		padding-left: .5em;
	}

</style>