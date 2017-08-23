<template>
	<div>
		<button class="button_prefs button_prefs_budget user_data button">
			Wilson Budget
		</button>
		<ul class='nav_main'>
			<li
				@click="goToBudget"
				tag="li"
				style="cursor: pointer"
				>
				<i class="law icon"></i>Budget</li>
			<li
				@click="goToAllAccounts"
				tag="li"
				style="cursor: pointer"
				>
				<i class="folder open icon"></i>All Accounts</li>
		</ul>
		
		<app-account-list :budgetAccounts="accounts"></app-account-list>
		
		<button class="button_sidebar nav_add_account" @click="showModal = true">
			<i class="icon add circle"></i>
			Add Account
		</button>

		<app-input-modal v-if="showModal" @close="cancelAddAccount" @submit="addAccount">
			<h3 slot="header">Add New Account</h3>
			<div class="modal_inputs">
				<label>Account Name:</label>
				<input type="text" v-model="accountName" placeholder="Account Name">
				
				<br>
				
				<label>Account Type:</label>
				<select name="account_type" v-model="accountType">
					<option>Select an Account Type</option>
					<optgroup label="Budget">
						<option value="checking">Checking</option>
						<option value="savings">Savings</option>
						<option value="credit_card">Credit Card</option>
						<option value="cash">Cash</option>
						<option value="line_credit">Line of Credit</option>
						<option value="paypal">PayPal</option>
						<option value="merchant_account">Merchant Account</option>
					</optgroup>
					<optgroup label="Tracking">
						<option value="invest_acc">Investment Account</option>
						<option value="mortgage">Mortgage</option>
						<option value="other_asset">Other Asset</option>
						<option value="other_liability">Other Liability</option>
					</optgroup>
				</select>
				
				<br>

				<label>Amount:</label>
				<input type="text" v-model="accountAmount" placeholder="Starting Amount">
			</div>
		</app-input-modal>
	</div>
</template>

<script>
	import axios from 'axios'
	import {mapGetters, mapActions} from 'vuex'
	import AccountListSB from './AccountListSB.vue'
	import InputModal from '../InputModals/InputModal.vue'
	export default {
		data() {
			return {
				showModal: false,
				accountName: '',
				accountType: '',
				accountAmount: null
			}
		},
		computed: {
			...mapGetters(['month', 'year']),
			accounts() {
				return this.$store.state.accounts
			}
		},
		components: {
			appAccountList: AccountListSB,
			appInputModal: InputModal
		},
		methods: {
			...mapActions([
				'getAccounts',
				'getTransactions',
				'getToBeBudgeted',
				'getBudgetCategories'
			]),
			goToAllAccounts() {
				this.$router.push(
					'/app/budget/' + this.$route.params.b_id + 
					'/' + this.month + '/' + this.year + '/acc/accounts')
			},
			goToBudget() {
				this.$router.push(
					'/app/budget/' + this.$route.params.b_id + '/' + this.month + '/' + this.year)
			},
			addAccount() {
				axios.post(
					'http://localhost:3000/api/' + this.$route.params.b_id + '/accounts/new',
					{
						name: this.accountName,
						type: this.accountType,
						amount: this.accountAmount
					}).then(() => {
						this.getAccounts()
						this.getBudgetCategories()
						this.getToBeBudgeted()
						this.getTransactions()
					})
				this.cancelAddAccount()
			},
			cancelAddAccount() {
				this.accountName = '';
				this.accountAmount = 0;
				this.accountType = '';
				this.showModal = false;
			}
		},
		created() {
			this.getAccounts()
		}
	}
</script>

<style>
	.nav_main {
		clear: both;
	}

	.nav_main li {
		display: block;
		padding: .4em .25em .4em 0;
		font-size: 1.125em;
		font-weight: 300;
	}

	.nav_main li i {
		display: inline-block;
		width: 2em;
		height: 2em;
		margin: 0 .375em;
		padding: 0;
		padding-top: .05em;
		line-height: 2em;
		text-align: center;
		border-radius: 1000px;
	}

	.nav_main li:hover {
		background-color: rgba(0,89,111,0.4);
	}


	.button_prefs {
		width: 100%;
		clear: both;
		border-radius: 0;
		box-shadow: none;
		padding: .5em;
		font-size: 1.2em;
		font-weight: bold;
		border: none;
		background-color: transparent;
		color: #fff;
		transition: background-color 0.2s linear;
	}

	.button_prefs:hover {
		background-color: #1b8095;
	}

	.button_sidebar {
		margin: .8rem 1rem 5.5rem 1rem;
	}

	.button_sidebar {
		background-color: rgba(255,255,255,0.2);
		border: none;
		border-radius: 1000px;
		box-shadow: none;
		padding: .3em .6em .4em .4em;
		font-size: .8em;
		line-height: 1em;
		float: right;
		color: #fff;
	}
	
	.nav_add_account {
		cursor: pointer;
	}
	
</style>