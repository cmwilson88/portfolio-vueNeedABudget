<template>
		<router-link :to="routePath" tag="a" class="nav_account_row">
			<div class="nav_account_name">{{account.name | capitalize-words}}</div>
			<div class="nav_account_spacer"></div>
			<div class="nav_account_value user_data">${{account.amount | amount-with-comma}}</div>
		</router-link>
</template>

<script>
	export default {
		data() {
			return {
				routePath: "/app/budget/" + this.$route.params.b_id + "/acc/" + this.account.id
			}
		},
		props: ['account']
	}
</script>