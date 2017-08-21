<template>
	<div>
		<div class="budget_toolbar">
			<button @click="showModal = true" class="budget_toolbar_add_category button"><i class="icon add circle"></i>Category Group</button>
		</div>
		<app-input-modal v-if="showModal" @close="cancelNewGroup" @submit="addCategoryGroup">
			<h3 slot="header">Add New Category Group</h3>
			<div class="modal_inputs">
				<label>Category Group Name: </label>
				<input type="text" v-model="newGroupName" placeholder="Category Group">
			</div>
		</app-input-modal>
	</div>
</template>

<script>
	import axios from 'axios'
	import InputModal from '../InputModals/InputModal.vue'
	import {mapActions} from 'vuex'
	export default {
		data() {
			return {
				newGroupName: '',
				showModal: false
			}
		},
		methods: {
			...mapActions(['getBudgetCategories']),
			addCategoryGroup() {
				axios.post(
					'http://localhost:3000/api/' + this.$route.params.b_id + '/' + this.$route.params.mm + '/' + this.$route.params.yy + '/catgroups/new',
					{
						name: this.newGroupName
					})
					.then(() => {
						this.getBudgetCategories();
					})
				this.cancelNewGroup()
			},
			cancelNewGroup() {
				this.newGroupName = '';
				this.showModal = false;
			}
		},
		components: {
			appInputModal: InputModal
		}
	}
</script>

<style>
	.budget_toolbar {
		background-color: #fff;
		border-bottom: 1px solid #dfe4e9;
		border-top: 1px solid #042229;
		font-size: .8em;
		padding: .35em 0 0 .35em;
		height: 2.95em;
	}
	.budget_toolbar .button {
		background-color: transparent;
		color: #009cc2;
		border-radius: 0;
		padding: .3em .5em .3em .313em;
		height: 1.953em;
		border: none;
		box-shadow: none;
	}


</style>