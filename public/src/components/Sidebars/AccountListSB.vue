<template>
	<div class="nav_accounts">
		<div class="nav_account_block">
			<div class="nav_account_name">BUDGET</div>
			<div class="nav_account_spacer"></div>
			<div class="nav_account_value user_data">$0.00</div>
		</div>
			<router-link to="/app/budget/1/acc/1" tag="a" class="nav_account_row">
				<div class="nav_account_name">Checking</div>
				<div class="nav_account_spacer"></div>
				<div class="nav_account_value user_data">$0.00</div>
			</router-link>
			<router-link
				to="/app/budget/1/acc/1"
				tag="a"
				class="nav_account_row"
				>
				<div class="nav_account_name">Savings</div>
				<div class="nav_account_spacer"></div>
				<div class="nav_account_value user_data">$0.00</div>
			</router-link>
			<router-link
				to="/app/budget/1/acc/1"
				tag="a"
				class="nav_account_row"
				>
				<div class="nav_account_name">Credit Card</div>
				<div class="nav_account_spacer"></div>
				<div class="nav_account_value user_data">$0.00</div>
			</router-link>
	</div>
</template>

<script>
	
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
		font-size: 1em;
		padding-left: 3em;
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