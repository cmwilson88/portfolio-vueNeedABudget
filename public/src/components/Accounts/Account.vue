<template>
	<div>
		<div>
			<router-link 
				:to="routePath" 
				tag="div" 
				class="nav_account_row">
				<div class="nav_account_name">
					<div class="nav_account_name_val">
						<span>{{account.name | capitalize-words}}</span>
					</div>
					<i @click="editModal = true" class="icon edit"></i>
				</div>
				<div class="nav_account_spacer"></div>
				<div class="nav_account_value user_data">${{account.amount | amount-with-comma}}</div>
			</router-link>
		</div>

		<app-input-modal v-if="editModal" @close="editModal = false">
			<h3 slot="header">Edit Account</h3>
			<div class="modal_inputs">
				<label>Account Name:</label>
				<input type="text" v-model="accountName">
			</div>
			<div slot="footer"class="modal_edit_buttons">
				<button>Save</button>
				<button @click="editModal=false">Cancel</button>
				<button @click="">Close Account</button>
			</div>
		</app-input-modal>

	</div>
</template>

<script>
	import axios from 'axios'
	import InputModal from '../InputModals/InputModal.vue'
	import {mapActions} from 'vuex'
	export default {
		props: ['account'],
		data() {
			return {
				editModal: false,
				showEditButton: false,
				accountName: this.account.name,
				routePath: "/app/budget/" + this.$route.params.b_id + "/acc/" + this.account.id
			}
		},
		components: {
			appInputModal: InputModal
		}
	}
</script>