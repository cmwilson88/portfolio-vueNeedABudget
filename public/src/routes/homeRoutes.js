const Home = resolve => {
	// Whenever we want to load something that lives in the path...
	require.ensure(['../components/Home/Home.vue'], () => {
		// ...execute this function which is like resolving a promise
		resolve(require('../components/Home/Home.vue'));
	}, 'home');
}

const Splash = resolve => {
	require.ensure(['../components/Home/Splash.vue'], () => {
		resolve(require('../components/Home/Splash.vue'));
	}, 'home')
}



export const homeRoutes = {
		path: '/',
		component: Home,
		children: [
			{ path: '', component: Splash }
		]
}
