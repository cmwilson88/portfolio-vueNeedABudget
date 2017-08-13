<template>
	<ul class="budget_table_row spend_cat">
		<li class="spend_cat_name">{{spendcategory.name}}</li> 
		<li class="spend_cat_budgeted">${{spendcategory.budgeted.toFixed(2)}}</li>
		<li class="spend_cat_activity">${{spendcategory.activity.toFixed(2)}}</li>
		<li class="spend_cat_available">${{spendcategory.available.toFixed(2)}}</li>
	</ul>
</template>

<script>
	export default {
		props: ['spendcategory']
	}
</script>