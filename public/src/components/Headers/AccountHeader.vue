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
				<button 
					@click="showModal=true"
					class="add_transaction button">
					<i class="icon add circle"></i>
					Add a transaction
				</button>
			</div>
		</div>

		<app-input-modal 
			v-if="showModal"
			@close="showModal=false"
			@submit="addNewTransaction">
			<h3 slot="header">Add New Transaction</h3>
			<div class="app_add_transaction">
				<label for="account">Account:</label>
				<select name="account" v-model="newTransaction.account">
					<option selected disabled>Select an Account</option>
					<option 
						v-for="account in accounts"
						:value="account.id"
						key="account.id">{{account.name}}</option>
				</select>
				<br>
				<label for="date">Date:</label>
				<input type="date" v-model="newTransaction.date">
				<br>
				<label for="payee">Payee:</label>
				<select name="payees" v-model="newTransaction.payee">
					<option selected disabled>Select a Payee</option>
					<option 
						v-for="payee in payees"
						:value="payee.id"
						key="payee.id">{{payee.name}}</option>
				</select>
				<br>
				<label for="category">Category:</label>
				<select name="categories" v-model="newTransaction.category">
					<option selected disabled>Select a Category</option>
					<option 
						v-for="category in categories"
						:value="category.id"
						key="category.id">{{category.name}}</option>
				</select>
				<br>
				<label for="memo">Memo:</label>
				<input type="text" v-model="newTransaction.memo">
				<br>
				<label for="outflow">Outflow:</label>
				<input type="number" v-model="newTransaction.outflow">
				<br>
				<label for="inflow">Inflow:</label>
				<input type="number" v-model="newTransaction.inflow">
				<br>
			</div>

		</app-input-modal>
	</header>
</template>

<script>
	import axios from 'axios'
	import InputModal from '../InputModals/InputModal.vue'
	export default {
		props: ['getTransactions'],
		data() {
			return {
				accounts: [
					{id: 1, name: 'USAA Checking'},
					{id: 2, name: 'USAA Savings'},
					{id: 3, name: 'USAA Visa Credit Card'}
				],
				categories: [
					{id: 1, name: 'Rent/Mortgage'},
					{id: 2, name: 'Electric'},
					{id: 3, name: 'Water'}
				],
				payees: [
					{id: 1, name: 'DevMountain'},
					{id: 2, name: 'Electric'},
					{id: 3, name: 'Smiths'}
				],
				showModal: false,
				newTransaction: {
					account: '',
					date: '',
					payee: '',
					category: '',
					memo: '',
					outflow: null, 
					inflow: null
				}
			}
		},
		components: {
			appInputModal: InputModal
		},
		methods: {
			addNewTransaction() {
				axios.post('http://localhost:3000/api/' + this.$route.params.b_id + '/transactions/new',
					{
						account: this.newTransaction.account,
						date: this.newTransaction.date,
						payee: this.newTransaction.payee,
						category: this.newTransaction.category,
						memo: this.newTransaction.memo,
						outflow: Number(this.newTransaction.outflow)*-1,
						inflow: Number(this.newTransaction.inflow)
					}
				).then(() => console.log('post sent'))
				this.cancelNewTransaction()
				this.getTransactions()
			},
			cancelNewTransaction() {
				this.showModal = false;
				this.newTransaction.account = '';
				this.newTransaction.date = '';
				this.newTransaction.payee = '';
				this.newTransaction.category = '';
				this.newTransaction.memo = '';
				this.newTransaction.outflow = null; 
				this.newTransaction.inflow = null;
			}
		}
	}
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

	.app_add_transaction {
		display: flex;
		flex-direction: column;
	}
</style>