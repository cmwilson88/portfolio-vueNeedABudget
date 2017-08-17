import Vue from 'vue'
import Vuex from 'vuex'

import axios from 'axios'


Vue.use(Vuex)

const state = {
	accounts: [],
	transactions: [],
	budgetCategories: []
}

const getters = {
	filteredTransactions(state) {
		if(state.route.params.acc_id) {
			return state.transactions.filter(transaction => transaction.account_id == state.route.params.acc_id)
		} else {
			return state.transactions
		}
	},
	accountDisplayName(state) {
		if(state.accounts) {
			if(state.route.params.acc_id) {
				return state.accounts.find(account => account.id == state.route.params.acc_id)
			}
		}
	},
	totalBudgeted(state) {
		return state.budgetCategories.reduce((a,b) => a + b.budgetgroup.budgeted, 0)
	},
	totalActivity(state) {
		return state.budgetCategories.reduce((a,b) => a + b.budgetgroup.activity, 0)
	},
	totalAvailable(state) {
		return state.budgetCategories.reduce((a,b) => a + b.budgetgroup.available, 0)
	}
}

const mutations = {
	GET_BUDGET_CATEGORIES(state, payload) {
		state.budgetCategories = payload
	},
	GET_TRANSACTIONS(state, payload) {
		state.transactions = payload
	},
	GET_ACCOUNTS(state, payload) {
		state.accounts = payload
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
		return axios.get(`http://localhost:3000/api/budget/${state.route.params.b_id}`)
					.then(res => commit('GET_BUDGET_CATEGORIES', res.data))
					.catch(err => console.log(err))
	}
}

export default new Vuex.Store({
	state,
	getters,
	mutations,
	actions
})