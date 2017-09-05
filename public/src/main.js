import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'
import axios from 'axios'
import VueAxios from 'vue-axios'

import {routes} from './routes/routes.js'

import store from './vuex/store'
import {sync} from 'vuex-router-sync'

// Vue Router
Vue.use(VueRouter)

const router = new VueRouter({
	routes: routes
})


export const eventBus = new Vue();

//global filter to change amounts retrieved from database into readable larger money formats
Vue.filter('amount-with-comma', function(value) {
	return Number(value).toLocaleString(
		undefined,
		{minimumFractionDigits: 2}
	)
})

Vue.filter('capitalize-words', function(value) {
	return value.split(' ').map(words => {
		return words[0].toUpperCase() + words.substr(1)
	}).join(' ')
})


Vue.use(VueAxios, axios)
// axios.defaults.withCredentials = true;

sync(store, router)

new Vue({
  el: '#app',
  router: router,
  store,
  render: h => h(App)
})
