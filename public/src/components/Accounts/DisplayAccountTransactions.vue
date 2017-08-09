<template>
	<div>
		<h1>Account Name</h1>
		<button @click="addNew = !addNew">Add New Transaction</button>
		<app-add-transaction v-if="addNew"></app-add-transaction>
		<ul>
			<li>Transaction 1</li>
			<li>Transactoin 2</li>
			<li>Transactoin 3</li>
			<li>Transactoin 4</li>
			<li>Transactoin 5</li>
			<li>Transactoin 6</li>
			<li>Transactoin 7</li>
			<li>Transactoin 8</li>
			<li>Transactoin 9</li>
			<li>Transactoin 10</li>
		</ul>
	</div>
</template>

<script>
	import AddTransaction from '../Transactions/AddTransaction.vue'
	export default {
		data() {
			return {
				addNew: false
			}
		},
		components: {
			appAddTransaction: AddTransaction
		}
	}
</script>