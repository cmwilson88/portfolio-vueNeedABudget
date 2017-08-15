<template>
	<div class="flex_columns">
		<app-account-header></app-account-header>
		<app-display-transactions 
			:transactions="computedTransactions" 
			:getTransactions="getTransactions"></app-display-transactions>
	</div>
</template>

<script>
	import axios from 'axios'
	import AccountHeader from '../Headers/AccountHeader.vue'
	import DisplayAllTransactions from '../Accounts/DisplayAllTransactions.vue'
	export default {
		data() {
			return {
				transactions: [],
				path: this.$route.params.acc_id
			}
		},
		methods: {
			getTransactions() {
				axios.get('http://localhost:3000/api/'+this.$route.params.b_id+'/transactions')
					.then(res => {
						this.transactions = res.data;
				})
			}
		},
		computed: {
			computedTransactions: function() {
				if(this.path) {
					return this.transactions.filter(transaction => transaction.account_id === this.path * 1)
				} else {
					return this.transactions
				}
			}
		},
		watch: {
			'$route': function() {
				console.log('route watch')
				this.path = this.$route.params.acc_id
			}
		},
		components: {
			appAccountHeader: AccountHeader,
			appDisplayTransactions: DisplayAllTransactions
		},
		created() {
			console.log('created')
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