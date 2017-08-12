<template>
	<div class="account_grid_body_row">
		<div class="account_grid_cell account_grid_cell_checkbox"></div>
		<div class="account_grid_cell account_grid_cell_notification"></div>
		<div class="account_grid_cell account_grid_cell_flag"></div>
		<div class="account_grid_cell account_grid_cell_accountName">{{transaction.account}}</div>
		<div class="account_grid_cell account_grid_cell_date">{{transaction.date}}</div>
		<div class="account_grid_cell account_grid_cell_payeeName">{{transaction.payee}}</div>
		<div class="account_grid_cell account_grid_cell_subCategoryName">{{transaction.category}}</div>
		<div class="account_grid_cell account_grid_cell_memo">{{transaction.memo}}</div>
		<div class="account_grid_cell account_grid_cell_outflow">{{transaction.outflow}}</div>
		<div class="account_grid_cell account_grid_cell_inflow">{{transaction.inflow}}</div>
		<div class="account_grid_cell account_grid_cell_cleared"></div>
	</div>
</template>

<script>
	export default {
		props: ['transaction']
	}
</script>
