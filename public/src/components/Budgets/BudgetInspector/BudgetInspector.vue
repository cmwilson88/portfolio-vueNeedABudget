<template>
	<aside class="budget_inspector">
		<app-default-inspector></app-default-inspector>
	</aside>
</template>

<script>
	import DefaultInspector from './DefaultInspector.vue';
	import {mapActions} from 'vuex'
	export default {
		methods: {
			...mapActions(['getTransactions'])
		},
		components: {
			appDefaultInspector: DefaultInspector
		},
		created() {
			this.getTransactions()
		}
	}
</script>

<style>
	.budget_inspector {
		position: absolute;
		display: block;
		width: 33%;
		min-width: 276px;
		top: 9.5em;
		right: 0;
		bottom: 0;
		z-index: 10;
		overflow: auto;
		background-color: #e5f5f9;
		border-left: 1px solid #e1e1e1;
		padding: 1em;
		font-size: .8em;
		color: #003440;
	}

	@media(max-width: 1100px) {
		.budget_inspector {
			left: 562px;
		}
	}
</style>