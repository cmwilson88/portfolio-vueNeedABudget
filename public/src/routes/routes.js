import {homeRoutes} from './homeRoutes'
import MainLayout from '../components/MainLayout.vue'
import BudgetNav from '../components/Sidebars/BudgetNav.vue'
import ContentBudget from '../components/ContentDisplays/ContentBudget.vue'
import DisplayAllTransactions from '../components/Accounts/DisplayAllTransactions.vue'


export const routes = [
	homeRoutes,
	{
		path: '/app',
		component: MainLayout,
		children: [
			{
				path: 'budget/:id', 
				components: {
					sidebar: BudgetNav,
					content: ContentBudget
				},
			},
			{
				path: 'budget/:id/accounts',
				components: {
					sidebar: BudgetNav,
					content: DisplayAllTransactions
				}
			}
		]
	}
]