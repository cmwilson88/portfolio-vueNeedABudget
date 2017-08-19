import {homeRoutes} from './homeRoutes'
import MainLayout from '../components/MainLayout.vue'
import BudgetNav from '../components/Sidebars/BudgetNav.vue'
import ContentBudget from '../components/ContentDisplays/ContentBudget.vue'
import ContentTransactions from '../components/ContentDisplays/ContentTransactions.vue'
import DisplayAllTransactions from '../components/Accounts/DisplayAllTransactions.vue'
import ContentBudgetSelect from '../components/ContentDisplays/ContentBudgetSelect.vue'



export const routes = [
	homeRoutes,
	{
		path: '/app',
		component: MainLayout,
		children: [
			{
				path: 'budget',
				components: {
					content: ContentBudgetSelect
				}
			},
			{
				path: 'budget/:b_id/:mm/:yy', 
				components: {
					sidebar: BudgetNav,
					content: ContentBudget
				},
			},
			{
				path: 'budget/:b_id/:mm/:yy/acc/accounts',
				components: {
					sidebar: BudgetNav,
					content: ContentTransactions,
				}
			},
			{
				path: 'budget/:b_id/:mm/:yy/acc/:acc_id',
				components: {
					sidebar: BudgetNav,
					content: ContentTransactions
				}
			}
		]
	}
]