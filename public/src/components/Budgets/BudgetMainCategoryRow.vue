<template>
	<ul class="budget_table_row category_group">
		<li class="category_group_name">
				<span>{{budgetgroup.name}}</span>
				<button @click="addNewSpend = !addNewSpend">+</button>
		</li> 
		<li class="category_group_budgeted">${{budgetgroup.budgeted.toFixed(2)}}</li>
		<li class="category_group_activity">${{budgetgroup.activity.toFixed(2)}}</li>
		<li class="category_group_available">${{budgetgroup.available.toFixed(2)}}</li>
	</ul>
</template>

<script>
	export default {
		props: ['budgetgroup']
	}
</script>