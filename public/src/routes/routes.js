import {homeRoutes} from './homeRoutes'
import MainLayout from '../components/MainLayout.vue'
import BudgetNav from '../components/Sidebars/BudgetNav.vue'
import ContentBudget from '../components/ContentDisplays/ContentBudget.vue'
import ContentTransactions from '../components/ContentDisplays/ContentTransactions.vue'
import DisplayAllTransactions from '../components/Accounts/DisplayAllTransactions.vue'
import DisplayAccountTransactions from '../components/Accounts/DisplayAccountTransactions.vue'



export const routes = [
	homeRoutes,
	{
		path: '/app',
		component: MainLayout,
		children: [
			{
				path: 'budget/:b_id', 
				components: {
					sidebar: BudgetNav,
					content: ContentBudget
				},
			},
			{
				path: 'budget/:b_id/acc/accounts',
				components: {
					sidebar: BudgetNav,
					content: ContentTransactions,
				}
			},
			{
				path: 'budget/:b_id/acc/:acc_id',
				components: {
					sidebar: BudgetNav,
					content: ContentTransactions
				}
			}
		]
	}
]