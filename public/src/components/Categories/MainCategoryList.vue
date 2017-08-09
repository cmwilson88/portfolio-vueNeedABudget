<template>
	<div>
		<button @click="addNewGroup = !addNewGroup">Add New Category Group</button>
		<app-add-cat-group v-if="addNewGroup"></app-add-cat-group>
		<ul>
			<ul class="category_group_display">
				<li>Immediate Obligations</li> 
				<li>
					<button @click="addNewSpend = !addNewSpend">Add Spend Category</button>
				</li>
			</ul>
				<app-add-spend-cat v-if="addNewSpend"></app-add-spend-cat>
				<ul>
					<li>Rent - 900</li>
					<li>Groceries - 500</li>
					<li>Gas - 50</li>
				</ul>
			</li>
			<li class="category_group_display">True Expenses <button @click="addNewSpend = !addNewSpend">Add Spend Category</button>
				<app-add-spend-cat v-if="addNewSpend"></app-add-spend-cat>
				<ul>
					<li>Auto Maintenance</li>
					<li>Home Maintenance</li>
					<li>Renter's/Home Insurnace</li>
					<li>Medical</li>
					<li>Stuff I Forgot To Budget For</li>
				</ul>
			</li>
			<li class="category_group_display">Debt Payments <button @click="addNewSpend = !addNewSpend">Add Spend Category</button>
				<app-add-spend-cat v-if="addNewSpend"></app-add-spend-cat>
				<ul>
					<li>Student Loan</li>
					<li>Auto Loan</li>
				</ul>
			</li>
			<li class="category_group_display">Quality of Life Goals <button @click="addNewSpend = !addNewSpend">Add Spend Category</button>
				<app-add-spend-cat v-if="addNewSpend"></app-add-spend-cat>
				<ul>
					<li>Vacation</li>
					<li>Fitness</li>
					<li>Education</li>
				</ul>
			</li>
			<li class="category_group_display">Just For Fun <button @click="addNewSpend = !addNewSpend">Add Spend Category</button>
				<app-add-spend-cat v-if="addNewSpend"></app-add-spend-cat>
				<ul>
					<li>Dining Out</li>
					<li>Gaming</li>
					<li>Fun Money</li>
				</ul>
			</li>
		</ul>
	</div>
</template>

<script>
	import AddCategoryGroup from './AddCategoryGroup.vue'
	import AddSpendCategory from './AddSpendCategory.vue'
	export default {
		data() {
			return {
				addNewGroup: false,
				addNewSpend: false
			}
		},
		components: {
			appAddCatGroup: AddCategoryGroup,
			appAddSpendCat: AddSpendCategory
		}
	}
</script>

<style>
	.category_group_display {
		display: flex;
		width: 100%;
		background-color: #e5f5f9;
	}
</style>