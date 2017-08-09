<template>
	<div class="budget_view_header">
		<div class="month_display">
			<div class="last_month_button"></div>
			<h1>Aug 2017</h1>
			<div class="next_month_button"></div>
		</div>

		<div class="budget_allocate_display">
			<div class="to_be_budgeted">
				<h1 class="left_to_budget_amount">$0.00</h1>
				<p class="tbb_text">To Be Budgeted</p>
			</div>
			<div class="budget_states">
				<ul>
					<li>+$84745.50 Funds for Aug</li>
					<li>-$0.00 Overspent in Jul</li>
					<li>-$6183.93 Budgeted in Aug</li>
					<li>-2561.57 Budgeted in Future</li>
				</ul>
			</div>
		</div>
	</div>
</template>

<script>
	
</script>

<style>
	.budget_view_header,
	.budget_allocate_display,
	.month_display {
		display: flex;
		justify-content: space-around;
		align-items: center;
	}

	.budget_view_header {
		padding: .6em;
		background-color: #003540;
		color: #fff;
	}

	.last_month_button,
	.next_month_button {
		height: 35px;
		width: 35px;
		background-color: #23B2CE;
		border-radius: 50%;
	}

	.to_be_budgeted {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: .55em .75em .5em .75em;
		border-radius: .5em;
		background-color: #16a336;
		color: #fff;
		overflow: hidden;
	}

	.last_month_button:hover,
	.next_month_button:hover {
		background-color: #22D4FF;
	}
</style>