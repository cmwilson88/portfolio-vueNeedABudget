<template>
	<div class="flex_columns">
		<app-account-header></app-account-header>
		<app-display-transactions></app-display-transactions>
	</div>
</template>

<script>
	import AccountHeader from '../Headers/AccountHeader.vue'
	import DisplayAllTransactions from '../Accounts/DisplayAllTransactions.vue'
	export default {
		components: {
			appAccountHeader: AccountHeader,
			appDisplayTransactions: DisplayAllTransactions
		}
	}
</script>

<style>
	.flex_columns {
		display: flex;
		flex-direction: column;
		height: 100%;
	}

	@media(max-width: 1100px) {
		.flex_columns {
			width: 838px;
		}
	}
</style>