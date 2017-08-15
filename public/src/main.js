import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'

import {routes} from './routes/routes.js'

Vue.use(VueRouter)


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

const router = new VueRouter({
	routes: routes
})

new Vue({
  el: '#app',
  router: router,
  render: h => h(App)
})
