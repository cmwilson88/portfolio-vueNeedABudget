<template>
	<div class="inspector_quick_budget">
		<h3>QUICK BUDGET</h3>
		<button class="budget_inspector_button">
			Underfunded: 
			<strong class="user_data">
				<span>$0.00</span>
			</strong>
		</button>
		<button class="budget_inspector_button">
			Budgeted Last Month: 
			<strong class="user_data">
				<span>$0.00</span>
			</strong>
		</button>
		<button class="budget_inspector_button">
			Spent Last Month:
			<strong class="user_data">
				<span>$0.00</span>
			</strong>
		</button>
		<button class="budget_inspector_button">
			Average Budgeted: 
			<strong class="user_data">
				<span>$0.00</span>
			</strong>
		</button>
		<button class="budget_inspector_button">
			Average Spent: 
			<strong class="user_data">
				<span>$0.00</span>
			</strong>
		</button>
	</div>
</template>

<script>
	
</script>

<style>
	.budget_inspector_button {
		border-radius: .4em;
		background-color: rgba(0,155,194,0.1);
		color: #009cc2;
		width: 100%;
		height: 30px;
		margin-bottom: 2px;
		padding: 0 .5em;
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}
</style>