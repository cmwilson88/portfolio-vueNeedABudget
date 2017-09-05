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

</style>