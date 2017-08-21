import Vue from 'vue'
import Vuex from 'vuex'

import axios from 'axios'


Vue.use(Vuex)

const state = {
	accounts: [],
	transactions: [],
	categories: [],
	toBeBudgeted: null,
	payees: [],
	today: ''
}

const getters = {
	filteredTransactions(state) {
		if(state.route.params.acc_id) {
			return state.transactions.filter(transaction => transaction.account_id == state.route.params.acc_id)
		} else {
			return state.transactions
		}
	},
	budgetCategories(state) {
		return state.categories.slice(1)
	},
	accountDisplayName(state) {
		if(state.accounts) {
			if(state.route.params.acc_id) {
				return state.accounts.find(account => account.id == state.route.params.acc_id)
			}
		}
	},
	inflowArray(state) {
		return state.transactions.filter(transaction => transaction.type === 'inflow')
	},
	totalBudgeted(state) {
		return state.categories.reduce((a,b) => a + b.budgetgroup.budgeted, 0)
	},
	totalActivity(state) {
		return state.categories.slice(1).reduce((a,b) => a + b.budgetgroup.activity, 0)
	},
	totalAvailable(state) {
		return state.categories.reduce((a,b) => a + b.budgetgroup.available, 0)
	},
	totalInflows(state) {
		let filteredArr = state.transactions.filter(
			transaction => transaction.trans_type === 'inflow' 
					&& transaction.trans_month == state.route.params.mm 
					&& transaction.trans_year == state.route.params.yy
			)
		console.log(filteredArr)
		let reducedArr = filteredArr.reduce((a,b) => a + Number(b.inflow), 0)
		return Number(reducedArr)
	},
	month(state) {
		return state.today.getMonth() + 1;
	},
	year(state) {
		return state.today.getFullYear()
	}

}

const mutations = {
	GET_BUDGET_CATEGORIES(state, payload) {
		state.categories = payload
	},
	GET_TO_BE_BUDGETED(state, payload) {
		state.toBeBudgeted = payload
	},
	GET_TRANSACTIONS(state, payload) {
		state.transactions = payload
	},
	GET_ACCOUNTS(state, payload) {
		state.accounts = payload
	},
	GET_PAYEES(state, payload) {
		state.payees = payload
	},
	GET_TODAY(state) {
		state.today = new Date();
	}
}

const actions = {
	getTransactions({commit}) {  
		return axios.get(`http://localhost:3000/api/${state.route.params.b_id}/transactions`)
						.then(res => commit('GET_TRANSACTIONS', res.data))
						.catch(err => console.log(err))
	},
	getAccounts({commit}) {
		return axios.get(`http://localhost:3000/api/${state.route.params.b_id}/accounts`)
			.then(res => commit('GET_ACCOUNTS', res.data))
			.catch(err => console.log(err))
	},
	getBudgetCategories({commit}) {
		return axios.get(`http://localhost:3000/api/budget/${state.route.params.b_id}/${state.route.params.mm}/${state.route.params.yy}`)
					.then(res => commit('GET_BUDGET_CATEGORIES', res.data))
					.catch(err => console.log(err))
	},
	getToBeBudgeted({commit}) {
		return axios.get(`http://localhost:3000/api/${state.route.params.b_id}`)
					.then(res => commit('GET_TO_BE_BUDGETED', res.data))
					.catch(err => console.log(err))
	},
	getPayees({commit}) {
		return axios.get(`http://localhost:3000/api/${state.route.params.b_id}/payees`)
					.then(res => commit('GET_PAYEES', res.data))
					.catch(err => console.log(err))
	},
	getToday({commit}) {
		commit('GET_TODAY')
	}
}

export default new Vuex.Store({
	state,
	getters,
	mutations,
	actions
})