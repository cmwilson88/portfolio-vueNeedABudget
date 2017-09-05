<template>
	<div 
		class="budget_select_div"
		@click="$router.push(goToBudgetURL)">
		{{budget.name | capitalize-words}}
	</div>
</template>

<script>
	export default {
		props: ['budget', 'month', 'year'],
		data() {
			return {
				goToBudgetURL: '/app/budget/' + this.budget.id + '/' + this.month + '/' + this.year
			}
		}
	}
</script>

<style>
	.budget_select_div {
		width: 150px;
		height: 150px;
		border: 15px solid #lightblue;
		margin: 10px;
	}
</style>