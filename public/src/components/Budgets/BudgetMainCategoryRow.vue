<template>
	<ul class="budget_table_row category_group">
		<li class="category_group_name">
				<span>{{budgetgroup.name}}</span>
				<button @click="addNewSpend = !addNewSpend">+</button>
		</li> 
		<li class="category_group_budgeted">${{budgetedTotal.toFixed(2) | amount-with-comma}}</li>
		<li class="category_group_activity">${{activityTotal.toFixed(2) | amount-with-comma}}</li>
		<li class="category_group_available">${{availableTotal.toFixed(2) | amount-with-comma}}</li>
	</ul>
</template>

<script>
	export default {
		props: ['budgetgroup'],
		computed: {
			budgetedTotal() {
				return this.budgetgroup.subcategories.reduce((a,b) => a + b.budgeted, 0)
			},
			activityTotal() {
				return this.budgetgroup.subcategories.reduce((a,b) => a + b.activity, 0)
			},
			availableTotal() {
				return this.budgetgroup.subcategories.reduce((a,b) => a + b.available, 0)
			}
		}
	}
</script>