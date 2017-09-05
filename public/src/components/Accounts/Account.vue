<template>
	<div>
		<div>
			<div
				@click="goToAccount" 
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
			</div>
		</div>

		<app-input-modal v-if="editModal" @close="editModal = false">
			<h3 slot="header">Edit Account</h3>
			<div class="modal_inputs">
				<label>Account Name:</label>
				<input type="text" v-model="accountName" @focus="accountName = ''">
			</div>
			<div slot="footer"class="modal_edit_buttons">
				<button @click="updateAccount">Save</button>
				<button @click="editModal=false">Cancel</button>
			</div>
		</app-input-modal>

	</div>
</template>

<script>
	import axios from 'axios'
	import InputModal from '../InputModals/InputModal.vue'
	import {mapActions, mapGetters} from 'vuex'
	export default {
		props: ['account'],
		data() {
			return {
				editModal: false,
				showEditButton: false,
				accountName: this.account.name
			}
		},
		computed: {
			...mapGetters(['month', 'year'])
		},
		components: {
			appInputModal: InputModal
		},
		methods: {
			...mapActions(['getAccounts']),
			updateAccount() {
				axios.patch('/api/accounts/' + this.account.id, {name: this.accountName})
					.then(() => {
						this.getAccounts();
						this.editModal = false;
						this.accountName = this.account.name
					})
			},
			goToAccount() {
				this.$router.push('/app/budget/1/' + this.month + '/' + this.year + '/acc/' + this.account.id)
			}
		}
	}
</script>