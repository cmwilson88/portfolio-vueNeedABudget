<template>
	<div class="account_grid">
		<div class="account_grid_header">
			<div class="account_grid_header_row">
				<div class="account_grid_header_cell account_grid_cell_checkbox">
					<div class="account_checkbox">
						<button role="checkbox" class="account_checkbox_button" aria-checked="false"></button>
					</div>
				</div>
				<div class="account_grid_header_cell account_grid_cell_notification"></div>
				<div class="account_grid_header_cell account_grid_cell_flag"></div>
				<div class="account_grid_header_cell account_grid_cell_accountName">
					ACCOUNT
				</div>
				<div class="account_grid_header_cell account_grid_cell_date">
					DATE
				</div>
				<div class="account_grid_header_cell account_grid_cell_payeeName">
					PAYEE
				</div>
				<div class="account_grid_header_cell account_grid_cell_subCategoryName">
					CATEGORY
				</div>
				<div class="account_grid_header_cell account_grid_cell_memo">
					MEMO
				</div>
				<div class="account_grid_header_cell account_grid_cell_outflow">
					OUTFLOW
				</div>
				<div class="account_grid_header_cell account_grid_cell_inflow">
					INFLOW
				</div>
				<div class="account_grid_header_cell account_grid_cell_cleared"></div>
			</div>
		</div>
		<div class="account_grid_container">
			<div class="account_grid_body">
				<app-transaction-row
					v-for="transaction in transactions"
					:transaction="transaction"
					key="transaction.id"
					>
				</app-transaction-row>
			</div>
		</div>
	</div>
</template>

<script>
	import axios from 'axios';
	import TransactionRow from './TransactionRow.vue'
	export default {
		data() {
			return {
				transactions: []
			}
		},
		created() {
			axios.get('http://localhost:3000/api/:acc_id')
				.then(res => {
					this.transactions = res.data;
				})
		},
		components: {
			appTransactionRow: TransactionRow
		}
	}
</script>

<style>
	.account_grid {
		flex: 1 1 auto;
		display: flex;
		flex-direction: column;
		height: 100%;
		width: 100%;
	}

	.account_grid_header {
		flex: 0 0 auto;
		display: table;
		table-layout: fixed;
		border-collapse: collapse;
		font-weight: normal;
		color: #4c7079;
		width: 100%;
	}

	.account_grid_header_row {
		display: table-row;
		background-color: #fff;
	}

	.account_grid_cell_checkbox, .account_grid_cell_notification,
	.account_grid_cell_flag, .account_grid_cell_cleared {
		text-align: center;
		width: 26px;
		text-overflow: initial !important;
	}
	.account_grid_header_cell {
		display: table-cell;
		font-size: .75em;
		line-height: 2.125;
		height: 2.25em;
		padding: 0 .5em;
		border: 1px solid #dee3e8;
		border-left: none;
		border-top: none;
		vertical-align: middle;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}

	.account_grid_header_cell .account_grid_cell_checkbox {
		padding: 0;
	}


	.account_checkbox {
		display: inline-block;
		cursor: default;
	}

	.account_grid_cell_checkbox .account_checkbox_button {
		padding: .35rem .4rem;
	}
	
	.account_grid_cell_accountName {
		width: 10%;
	}

	.account_grid_header_cell .account_grid_cell_date {
		width: 8.6em;
	}

	.account_grid_cell_payeeName {
		width: 16%;
	}

	.account_grid_cell_memo {
		width: 16%;
	}

	.account_grid_cell_outflow {
		text-align: right;
		width: 10%;
	}

	.account_grid_cell_inflow {
		text-align: right;
		width: 10%;
	}

	.account_grid_container {
		flex: 1 1 auto;
		width: 100%;
		height: 1px;
		overflow: auto;
	}

	.account_grid_body {
		width: 100%;
		display: table;
		table-layout: fixed;
		border-collapse: collapse;
		font-weight: normal;
	}

	.account_grid_body_row {
		display: table-row;
		width: 100%;
		height: 30px;
		margin: 0;
		padding: 0;
		border-bottom: 1px solid #dfe4e9;
		font-size: .9285em;
		cursor: pointer;
	}

	.account_grid_cell {
		display: table-cell;
		padding: .3em 0;
		font-size: .875em;
		text-overflow: ellipsis;
		vertical-align: middle;
		overflow: hidden;
		white-space: nowrap;
	}

	.account_grid_body_row .account_grid_cell_checkbox {
		padding: 0;
		line-height: 2;
	}

	.account_grid_body_row .account_grid_cell_checkbox,
	.account_grid_body_row .account_grid_cell_flag {
		text-align: center;
		font-size: 1em;
		padding-left: .3em;
		overflow: visible;
	}

	.account_grid_body_row .account_grid_cell_accountName,
	.account_grid_body_row .account_grid_cell_date,
	.account_grid_body_row .account_grid_cell_payeeName,
	.account_grid_body_row .account_grid_cell_subCategoryName {
		padding-left: .5em;
	}

	.account_grid_body_row .account_grid_cell_outflow,
	.account_grid_body_row .account_grid_cell_inflow {
		padding-right: .6em;
	}
	@media (max-width: 1100px) {
		.account_grid_header,
		.accoutn_grid_body_row {
			width: 838px;
		}
	}
</style>