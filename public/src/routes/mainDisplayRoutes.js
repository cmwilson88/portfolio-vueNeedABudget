const MainCategoryList = resolve => {
	require.ensure(['../components/Categories/MainCategoryList.vue'], () => {
		resolve(require('../components/Categories/MainCategoryList.vue'));
	}, 'mainDisplay');
}

const DisplayAccountTransactions = resolve => {
	require.ensure(['../components/Accounts/DisplayAccountTransactions.vue'], () => {
		resolve(require('../components/Accounts/DisplayAccountTransactions.vue'));
	}, 'mainDisplay')
}

const DisplayAllTransactions = resolve => {
	require.ensure(['../components/Accounts/DisplayAllTransactions.vue'], () => {
		resolve(require('../components/Accounts/DisplayAllTransactions.vue'));
	}, 'mainDisplay');
}

export const mainDisplayRoutes = [
				{ path: '', component: MainCategoryList},
				{ path: 'accounts', component: DisplayAllTransactions},
				{ path: '1', component: DisplayAccountTransactions}
			]