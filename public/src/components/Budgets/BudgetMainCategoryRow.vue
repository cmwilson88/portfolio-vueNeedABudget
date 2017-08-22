<template>
	<ul class="budget_table_row category_group" @contextmenu.prevent="editModal = true">
		<li 
			class="category_group_name" 
			@mouseenter="showAddButton = true" 
			@mouseleave="showAddButton = false">
				{{budgetgroup.name | capitalize-words}}
				<div 
					v-show="showAddButton" 
					style="cursor: pointer"
					@click="addModal = true"><i class="icon add circle"></i>
					</div>
		</li> 

		<app-input-modal v-if="addModal" @close="cancelNewSpend" @submit="addSpendCategory">
			<h3 slot="header">New Spending Category</h3>
			<div class="modal_inputs">
				<label>Spending Category Name: </label>
				<input type="text" v-model="spendCatName" placeholder="New Spending Category">
			</div>
		</app-input-modal>

		<app-input-modal v-if="editModal" @close="editModal = false">
			<h3 slot="header">Edit Category Group</h3>
			<div class="modal_inputs">
				<label>Category Group Name:</label>
				<input type="text" v-model="catGroupName">
			</div>
			<div slot="footer"class="modal_edit_buttons">
				<button @click="updateCatGroup">Save</button>
				<button @click="editModal=false">Cancel</button>
				<button @click="deleteCategoryGroup">Delete</button>
			</div>
		</app-input-modal>

		<app-input-modal v-if="errCode">
			<h3 slot="header">Error!</h3>
			<h1 class="modal_inputs" style="text-align: center">ERROR! Unable to delete category group at this time.</h1>
			<button slot="footer" @click="errCode = false">Close</button>
		</app-input-modal>

		<li class="category_group_budgeted">
			${{budgetgroup.budgeted | amount-with-comma}}
		</li>
		<li class="category_group_activity">
			${{budgetgroup.activity | amount-with-comma}}
		</li>
		<li class="category_group_available" style="padding-right: 8px">
			${{budgetgroup.available | amount-with-comma}}
		</li>
	</ul>
</template>

<script>
	import axios from 'axios'
	import InputModal from '../InputModals/InputModal.vue'
	import {mapActions, mapGetters} from 'vuex'
	export default {
		props: ['budgetgroup'],
		data() {
			return {
				addModal: false,
				editModal: false,
				showAddButton: false,
				spendCatName: '',
				catGroupName: '',
				catgroup_id: this.budgetgroup.id,
				catgroup_act_id: this.budgetgroup.catgroup_act_id,
				errCode: ''
			}
		},
		methods: {
			...mapActions(['getBudgetCategories']),
			mouseOver() {
				this.showAddButton = !this.showAddButton
			},
			addSpendCategory() {
				axios.post(
						'http://localhost:3000/api/' 
						+ this.$route.params.b_id 
						+ '/' + this.$route.params.mm + '/' 
						+ this.$route.params.yy + '/spendcats/new',
						{
							name: this.spendCatName,
							catgroup_id: this.catgroup_id,
							catgroup_act_id: this.budgetgroup.catgroup_avail_id,
							catgroup_avail_id: this.budgetgroup.catgroup_avail_id
						}
					)
					.then(() => {
						this.getBudgetCategories();
						this.cancelNewSpend();
					}).catch(err => console.log(err))
				this.cancelNewSpend();
			},
			updateCatGroup() {
				console.log(this.catGroupName)
				axios.patch('http://localhost:3000/api/catgroups/' + this.budgetgroup.id, {name: this.catGroupName})
					.then(() => {
						this.getBudgetCategories();
						this.editModal = false
						this.catGroupName = ''
					}).catch(err => console.log(err))
			},
			deleteCategoryGroup() {
				axios.delete('http://localhost:3000/api/catgroups/' + this.budgetgroup.id)
					.then(() => {
						this.getBudgetCategories()
						this.editModal = false
					}).catch(err => {
						this.errCode = true
						this.editModal = false
					})
			},
			cancelNewSpend() {
				this.addModal = false;
				this.spendCatName = '';
			}
		},
		components: {
			appInputModal: InputModal
		}
	}
</script>