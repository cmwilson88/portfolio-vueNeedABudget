<template>
	<div class="nav_accounts">
		<div class="nav_account_block">
			<div class="nav_account_name">BUDGET</div>
			<div class="nav_account_spacer"></div>
			<div class="nav_account_value user_data">${{accountsTotal | amount-with-comma}}</div>
		</div>
			<app-account
				v-for="account in budgetAccounts"
				:account="account"
				key="account.id">
			</app-account>
	</div>
</template>

<script>
	import axios from 'axios'
	import Account from '../Accounts/Account.vue'
	export default {
		props: ['budgetAccounts'],
		computed: {
			accountsTotal() {
				return this.budgetAccounts 
					? this.budgetAccounts.reduce((a,b) => a + Number(b.amount), 0) 
					: null
			}
		},
		components: {
			appAccount: Account
		}
	}
</script>

<style>
	.nav_accounts {
		width: 100%;
		margin: 0 auto;
		line-height: 1.5;
		border-top: 1px solid #338ca2;
	}

	.nav_account_block {
		cursor: pointer;
		display: flex;
		align-items: center;
		padding: .45em 0 .1em 0;
		margin-bottom: .05em;
		font-weight: 700;
	}

	.nav_account_row {
		cursor: pointer;
		display: flex;
		padding: 0.5em 0;
	}

	.nav_account_row:hover {
		background-color: #1b8095;
	}

	.nav_account_row .nav_account_name {
		display: table-cell;
		font-size: .875em;
		padding-left: 2em;
	}

	.nav_account_name {
		flex: 0 0 160px;
		padding-left: 1.76em;
		font-size: .675em;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
		display: flex;
		align-items: center;
	}

	.nav_account_spacer {
		flex: 1 1 auto;
	}

	.nav_account_value {
		display: flex;
		align-items: center;
		flex: 0 1 auto;
		text-align: right;
		padding-right: 1em;
		font-size: .75em;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}
</style>