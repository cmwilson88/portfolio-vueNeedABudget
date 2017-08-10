import {mainDisplayRoutes} from './mainDisplayRoutes'

// lazy loading syntax
const BudgetHome = resolve => {
	// Whenever we want to load something that lives in the path...
	require.ensure(['../components/Budgets/BudgetHome.vue'], () => {
		// ...execute this function which is like resolving a promise
		resolve(require('../components/Budgets/BudgetHome.vue'));
	// pass another argument to create a subgroup of components to load at same time
	}, 'budget');
}

const BudgetSelect = resolve => {
	// Whenever we want to load something that lives in the path...
	require.ensure(['../components/Budgets/BudgetSelect.vue'], () => {
		// ...execute this function which is like resolving a promise
		resolve(require('../components/Budgets/BudgetSelect.vue'));
	}, 'budget');
}

const CreateBudget = resolve => {
	// Whenever we want to load something that lives in the path...
	require.ensure(['../components/Budgets/CreateBudget.vue'], () => {
		// ...execute this function which is like resolving a promise
		resolve(require('../components/Budgets/CreateBudget.vue'));
	}, 'budget');
}

const MainLayout = resolve => {
	// Whenever we want to load something that lives in the path...
	require.ensure(['../components/Layouts/MainLayout.vue'], () => {
		// ...execute this function which is like resolving a promise
		resolve(require('../components/Layouts/MainLayout.vue'));
	}, 'budget');
}



export const budgetRoutes = {
	path: '/budget',
	component: BudgetHome,
	children: [
		{ path: '', component: BudgetSelect},
		{ path: 'new', component: CreateBudget},
		{ 
			path: ':budget_id', 
			component: MainLayout,
			children: mainDisplayRoutes
		}
	]
}