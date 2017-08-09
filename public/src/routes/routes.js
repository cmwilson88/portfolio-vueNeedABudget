import Home from '../components/Home/Home.vue'
import {budgetRoutes} from './budgetRoutes'



export const routes = [
	{
		path: '/',
		name: 'home',
		component: Home
	},
	budgetRoutes

]