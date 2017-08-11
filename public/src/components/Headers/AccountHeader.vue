<template>
	<header class="accounts_header">
		<div class="accounts_header_top">
			<div class="accounts_header_total">
				<div class="accounts_header_total_inner">
					<div class="accounts_header_total_inner_label">
						All Accounts
					</div>
					<div class="arrow"></div>
				</div>
			</div>
			<div class="accounts_header_balances">
				<div class="accounts_header_balances_cleared">
					<div class="accounts_header_balances_label">Cleared Balance</div>
					<span class="user_data">$0.00</span>
				</div>
				<i>+</i>
				<div class="accounts_header_balances_uncleared">
					<div class="accounts_header_balances_label">Uncleared Balance</div>
					<span class="user_data">$0.00</span>
				</div>
				<i>=</i>
				<div class="accounts_header_balances_working">
					<div class="accounts_header_balances_label">Working Balance</div>
					<span class="user_data">$0.00</span>
				</div>
			</div>
		</div>
		<div class="accounts_toolbar">
			<div class="accounts_toolbar_left">
				<button class="add_transaction button">
					<i class="icon add circle"></i>
					Add a transaction
				</button>
			</div>
		</div>
	</header>
</template>

<script>
	
</script>

<style>
	.accounts_header {
		flex: 0 0 auto;
		position: inherit;
		top: 0;
		left: 260px;
		right: 0;
		width: inherit;
		min-width: 838px;
		height: 6.2em;
		border-bottom: 1px solid #042229;
		color: #fff;
		background-color: #003540;
		font-weight: bold;
		overflow: visible;
		z-index: 11;
	}

	.accounts_header .accounts_header_top {
		display: flex;
		align-items: flex-start;
	}

	.accounts_header .accounts_header_total {
		padding: 0;
		flex: 0 1 auto;
	}

	.accounts_header .accounts_header_total_inner {
		position: relative;
		float: left;
		margin: .5em .75em .65em .5em;
		border-radius: .4em;
		background-color: #16a336;
		color: #fff;
		text-align: center;
		padding: .2em;
		font-size: 1.3125em;
		line-height: 1em;
	}

	.accounts_header
	.accounts_header_total_inner
	.accounts_header_total_inner_label {
		margin: 0 auto;
		padding: .3em .25em;
		font-size: 1em;
		font-weight: 300;
		color: #fff;
		max-width: 300px;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}

	.accounts_header
	.accounts_header_total_inner
	.arrow {
		position: absolute;
		border-top: .5em solid transparent;
		border-bottom: .5em solid transparent;
		border-left: .5em solid #16a336;
		top: 50%;
		margin-top: -.5em;
		right: -.45em;
	}

	.accounts_header .accounts_header_balances {
		flex: 1 1 auto;
		display: flex;
		font-size: 1.1rem;
		overflow: hidden;
	}

	.accounts_header .accounts_header_balances_cleared,
	.accounts_header .accounts_header_balances_uncleared,
	.accounts_header .accounts_header_balances_working {
		flex: 0 1 auto;
		overflow: hidden;
		margin-top: .75em;
		text-align: center;
		color: #5bbe72;
	}

	.accounts_header .accounts_header_balances_label {
		font-style: italic;
		font-weight: normal;
		font-size: .7em;
		color: #fff;
	}

	.accounts_header .accounts_header_balances i {
		flex: 0 0 auto;
		display: block;
		color: #588697;
		font-size: 1em;
		font-style: normal;
		padding: 1.125em .5em 0 .5em;
	}

	.accounts_toolbar {
		background-color: #fff;
		border-bottom: 1px solid #dfe4e9;
		font-size: .8em;
		width: 100%;
		height: 2.95em;
		padding-top: .25em;
		clear: both;
	}

	.accounts_toolbar .accounts_toolbar_left {
		float: left;
		padding-left: .5em;
		width: 31rem;
	}

	.accounts_toolbar .button {
		display: flex;
		align-items: center;
		height: 2.2em;
		border: none;
	}

	.accounts_toolbar .button:hover {
		background-color: transparent;
		color: #005076;
	}
</style>