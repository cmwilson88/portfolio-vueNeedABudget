<template>
	<div>
		<ul class="budget_table_row spend_cat" @contextmenu.prevent="editModal = true">
			<li class="spend_cat_name">{{spendcategory.name}}</li> 
			<li class="spend_cat_budgeted">${{spendcategory.budgeted.toFixed(2) | amount-with-comma }}</li>
			<li class="spend_cat_activity">${{spendcategory.activity.toFixed(2) | amount-with-comma }}</li>
			<li class="spend_cat_available">${{spendcategory.available.toFixed(2) | amount-with-comma }}</li>
		</ul>
		<app-input-modal v-if="editModal" @close="editModal = false">
			<h3 slot="header">Edit Spending Category</h3>
			<div class="modal_inputs">
				<label>Spending Category Name:</label>
				<input type="text" v-model="name">
			</div>
			<div slot="footer"class="modal_edit_buttons">
				<button>Save</button>
				<button @click="editModal=false">Cancel</button>
				<button @click="deleteSpendCat">Delete</button>
			</div>
		</app-input-modal>
	</div>
</template>

<script>
	import axios from 'axios'
	import {mapActions} from 'vuex'
	import InputModal from '../InputModals/InputModal.vue'
	export default {
		props: ['spendcategory'],
		data() {
			return {
				editModal: false,
				id: this.spendcategory.id,
				name: this.spendcategory.name
			}
		},
		methods: {
			...mapActions(['getBudgetCategories']),
			deleteSpendCat() {
				axios.delete('http://localhost:3000/api/spendcats/' + this.id)
				.then(() => {
					this.getBudgetCategories();
					this.editModal = false
				})
			}
		},
		components: {
			appInputModal: InputModal
		}
	}
</script>