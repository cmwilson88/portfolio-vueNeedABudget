<template>
	<div class="budget_inspector_default">
		<h3>TOTAL BUDGETED</h3>
		<h1 class="user_data"><span>$0.00</span></h1>
		<hr>
		<h3>total activity</h3>
		<h1 class="user_data"><span>$0.00</span></h1>
		<hr>
		<h3>total available</h3>
		<h1 class="user_data"><span>$0.00</span></h1>
		<hr>
		<h3>total inflows</h3>
		<h1 class="user_data"><span>$0.00</span></h1>
		<hr>
		<app-quick-budget></app-quick-budget>
	</div>
</template>

<script>
	import QuickBudget from './QuickBudget.vue'
	export default {
		components: {
			appQuickBudget: QuickBudget
		}
	}
</script>

<style>
	.budget_inspector_default {
		color: #588697;
		line-height: 1em;
	}

	.budget_inspector_default h1,
	.budget_inspector_default h3 {
		text-align: center;
		text-decoration: none;
		border: none;
	}

	.budget_inspector_default h3 {
		position: relative;
		left: -2%;
		width: 104%;
		padding: .3em .5em .2em .5em;
		margin-top: 1.4em;
		margin-bottom: .5em;
		border-radius: 0;
		background-color: transparent;
		font-size: .875em;
		font-weight: 700;
		text-transform: uppercase;
	}

	.budget_inspector_default h1 {
		font-size: 2em;
		margin: 0;
		margin-bottom: .75em;
	}

	.budget_inspector_default h1 span {
		display: block;
		line-height: 1em;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}

	.budget_inspector_default hr {
		border-top: 0;
		border-left: 0;
		border-right: 0;
		border-bottom: 1px dotted #588697;
		width: 80%;
		height: .1em;
		color: transparent;
		background-color: transparent;
	}
</style>