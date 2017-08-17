<template>
	<div class="flex_columns">
		<app-account-header></app-account-header>
		<app-display-transactions 
			:transactions="filteredTransactions"></app-display-transactions>
	</div>
</template>

<script>
	import axios from 'axios'
	import AccountHeader from '../Headers/AccountHeader.vue'
	import DisplayAllTransactions from '../Accounts/DisplayAllTransactions.vue'
	import {mapGetters, mapActions} from 'vuex'
	export default {
		methods: {
			...mapActions([
					'getTransactions'
				])
		},
		computed: {
			...mapGetters([
					'filteredTransactions' 
				])
		},
		watch: {
			'$route': function() {
				this.accountPath = this.$route.params.acc_id
			}
		},
		components: {
			appAccountHeader: AccountHeader,
			appDisplayTransactions: DisplayAllTransactions
		},
		created() {
			this.getTransactions();
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