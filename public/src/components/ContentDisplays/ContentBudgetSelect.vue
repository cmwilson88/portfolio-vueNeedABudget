<template>
	<div>
		<h1>Select a Budget</h1>
		<p>This is where the user will select their desired budget</p>
		<button @click="goToBudget">To Budget</button>
	</div>
</template>

<script>
	import {mapGetters, mapActions} from 'vuex'
	export default {
		computed: {
			...mapGetters(['month', 'year'])
		},
		methods: {
			...mapActions(['getToday']),
			goToBudget() {
				this.$router.push('/app/budget/1/' + this.month + '/' + this.year)
			}
		},
		created() {
			this.getToday();
		}
	}
</script>