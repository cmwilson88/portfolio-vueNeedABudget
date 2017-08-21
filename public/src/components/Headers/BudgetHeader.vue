<template>
	<header class="budget_header">
		<div class="budget_header_flex">
			<div class="month_display budget_header_item">
				<div class="month_button" @click="goToLastMonth" style="cursor: pointer">
					<div class="month_button_inner">
						<i class="icon chevron left"></i>
					</div>
				</div>
				<h1>{{displayMonth}} / {{displayYear}}</h1>
				<div class="month_button" @click="goToNextMonth" style="cursor: pointer">
					<div class="month_button_inner">
						<i class="icon chevron right"></i>
					</div>
				</div>
			</div>

			<div class="budget_allocate_display budget_header_item">
				<div class="to_be_budgeted">
					<div class="tbb_totals_amount">
						<h1 class="tbb_value">${{toBeBudgeted | amount-with-comma}}</h1>
						<p class="tbb_text">To Be Budgeted</p>
					</div>
				</div>
				<div class="budget_totals_details">
					<div class="budget_totals_details_values">
						<div class="budget_totals_cell_value"><span>+${{totalInflows | amount-with-comma}}</span></div>
						<div class="budget_totals_cell_value"><span>-$0.00</span></div>
						<div class="budget_totals_cell_value"><span>-${{totalBudgeted | amount-with-comma}}</span></div>
						<div class="budget_totals_cell_value"><span>-$0.00</span></div>
					</div>
					<div class="budget_totals_details_names">
						<div class="budget_totals_cell_name">Funds for {{displayMonth}}/{{displayYear}}</div>
						<div class="budget_totals_cell_name">Overspent in {{previousMonth}}/{{displayYear}}</div>
						<div class="budget_totals_cell_name">Budgeted in {{displayMonth}}/{{displayYear}}</div>
						<div class="budget_totals_cell_name">Budgeted in Future</div>
					</div>
				</div>
			</div>
		</div>
		<app-add-category-group></app-add-category-group>
	</header>
</template>

<script>
	import AddCategoryGroup from '../Categories/AddCategoryGroup.vue'
	import {mapGetters, mapActions} from 'vuex'
	export default {
		computed: {
			...mapGetters(['totalBudgeted', 'totalInflows', 'month', 'year']),
			toBeBudgeted() {
				return this.$store.state.toBeBudgeted
			},
			previousMonth(){
				return this.$route.params.mm -1
			},
			displayMonth() {
				return this.$route.params.mm
			},
			displayYear() {
				return this.$route.params.yy
			}
		},
		methods: {
			...mapActions(['getBudgetCategories']),
			goToNextMonth() {
				if(this.displayMonth == 12) {
					let nextMonth = 1
					let nextYear = Number(this.displayYear) + 1
					this.$router.push('/app/budget/1/' + nextMonth + '/' + nextYear)
				} else {
					let nextMonth = Number(this.displayMonth) + 1
					this.$router.push('/app/budget/1/' + nextMonth + '/' + Number(this.displayYear))
				}
			},
			goToLastMonth() {
				if(this.displayMonth == 1) {
					let lastMonth = 12
					let lastYear = Number(this.displayYear) - 1
					this.$router.push('/app/budget/1/' + lastMonth + '/' + lastYear)
					this.getBudgetCategories();
				} else {
					let lastMonth = Number(this.displayMonth) - 1
					this.$router.push('/app/budget/1/' + lastMonth + '/' + Number(this.displayYear))
				}
			}
		},
		components: {
			appAddCategoryGroup: AddCategoryGroup
		}
	}
</script>

<style>
	.budget_header_flex {
		display: flex;
	}

	.budget_header {
		width: inherit;
		min-width: 838px;
		position: fixed;
		top: 0;
		left: 260px;
		right: 0;
		overflow: hidden;
		z-index: 11;
	}
	.budget_header_item {
		padding: .6em;
		border-left: 1px solid #0e414c;
		text-align: center;
		background-color: #003540;
		color: #fff;
	}

	.budget_header_item:first-child {
		border-left: none;
	}

	.month_display {
		display: flex;
		align-items: center;
		justify-content: center;
		position: relative;
		flex: 0 0 30%;
		
	}

	.month_display h1 {
		text-transform: uppercase;
		font-size: 1.25em;
		line-height: .75;
		font-weight: 700;
		padding: 0 .5em 0 .5em;
	}

	.month_button {
		display: flex;
		align-items: center;
		justify-content: center;
		height: 45px;
		width: 45px;
		background-color: #23B2CE;
		border-radius: 50%;
	}

	.month_button_inner{
		display: flex;
		align-items: center;
		justify-content: center;
		height: 35px;
		width: 35px;
		background-color: #003540;
		border-radius: 50%;
	}

	.month_button_inner i {
		margin: 0;
		font-size: 1.5em;
		color: #23b2ce;
	}

	.chevron.left {
		margin-right: .225em;
	}

	.chevron.right {
		margin-left: .225em;
	}

	.budget_allocate_display {
		display: flex;
		align-items: center;
		justify-content: center;

		flex: 3 1 auto;

		overflow: hidden;
	}

	.to_be_budgeted {
		display: flex;
		align-items: center;
		justify-content: center;
		overflow: hidden;
	}

	.tbb_totals_amount {
		flex: 0 1 auto;
		font-size: .9em;
		max-height: 4.9em;
		border-radius: .5em;
		background-color: #16a336;
		color: #fff;
		padding: .55em .75em .5em .75em;
		overflow: hidden;
	}

	.tbb_value {
		width: 100%;
		margin: .5em 0;

		font-size: 2em;
		font-weight: 300;
		line-height: .5;
	}

	.tbb_text {
		margin-top: .2em;
		color: #003550;
		font-style: italic;
	}
	
	.budget_totals_details {
		flex: 0 1 auto;
		display: flex;
		font-size: .8em;
		overflow: hidden;
		margin-left: 1.5em;
	}

	.budget_totals_details_values {
		flex: 0 1 auto;
		overflow: hidden;
	}

	.budget_totals_cell_value {
		overflow: hidden;
		text-align: right;
		font-weight: 700;
		margin: .25em 0;
	}

	.budget_totals_cell_value span {
		display: block;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap
	}

	.budget_totals_details_names {
		flex: 0 0 auto;
	}

	.budget_totals_cell_name {
		margin: .25em 0;
		text-align: left;
		font-style: italic;
		padding-left: .3em;
		white-space: nowrap;
	}
</style>