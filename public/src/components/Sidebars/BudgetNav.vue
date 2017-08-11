<template>
	<div>
		<button class="button_prefs button_prefs_budget user_data button">
			Wilson Budget
		</button>
		<ul class='nav_main'>
			<router-link
				to="/app/budget/1"
				tag="li"
				style="cursor: pointer"
				>
				<i class="law icon"></i> Budget</router-link>
			<router-link
				to="/app/budget/1/accounts"
				tag="li"
				style="cursor: pointer"
				>
				<i class="folder open icon"></i>All Accounts</router-link>
		</ul>
		<app-account-list></app-account-list>
	</div>
</template>

<script>
	import AccountListSB from './AccountListSB.vue'
	export default {
		components: {
			appAccountList: AccountListSB
		}
	}
</script>

<style>
	.nav_main {
		clear: both;
	}

	.nav_main li {
		display: block;
		padding: .4em .25em .4em 0;
		font-size: 1.125em;
		font-weight: 300;
	}

	.nav_main li i {
		display: inline-block;
		width: 2em;
		height: 2em;
		margin: 0 .375em;
		padding: 0;
		padding-top: .05em;
		line-height: 2em;
		text-align: center;
		border-radius: 1000px;
	}

	.nav_main li:hover {
		background-color: rgba(0,89,111,0.4);
	}


	.button_prefs {
		width: 100%;
		clear: both;
		border-radius: 0;
		box-shadow: none;
		padding: .5em;
		font-size: 1.2em;
		font-weight: bold;
		border: none;
		background-color: transparent;
		color: #fff;
		transition: background-color 0.2s linear;
	}

	.button_prefs:hover {
		background-color: #1b8095;
	}
</style>