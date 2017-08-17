<template>
	<div id="modal-template">
		<transition name="modal">
		    <div class="modal-mask" @click="$emit('close')">
		      <div class="modal-wrapper">
		        <div class="modal-container" @click.stop>

		          <div class="modal-header">
		            <slot name="header">
		              default header
		            </slot>
		          </div>

		          <div class="modal-body">
		            <slot>
		              default body
		            </slot>
		          </div>

		          <div class="modal-footer">
		            <slot name="footer">
		              <button class="modal-default-button" @click="$emit('submit')">
		                Submit
		              </button>
		              <button class="modal-default-button" @click="$emit('close')">
		              	Cancel
		              </button>
		            </slot>
		          </div>
		        </div>
		      </div>
		    </div>
		</transition>
	</div>
</template>

<script>

</script>

<style>
	.modal-mask {
	  position: fixed;
	  z-index: 9998;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100%;
	  background-color: rgba(0, 0, 0, .65);
	  display: table;
	  transition: opacity .3s ease;
	}

	.modal-wrapper {
	  display: table-cell;
	  vertical-align: middle;
	}

	.modal-container {
	  display: flex;
	  flex-direction: column;
	  align-items: center;	
	  width: 450px;
	  padding-bottom: 30px;
	  margin: 0px auto;
	  background: linear-gradient(to bottom, #34aebe, #23809b);
	  border-radius: 35px;
	  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
	  transition: all .3s ease;
	  font-family: Helvetica, Arial, sans-serif;
	}
	
	.modal-header {
		background-color: #003540;
		border-top-right-radius: 35px;
		border-top-left-radius: 35px;
		text-align: center;
		padding: 1em 1em;
		width: 100%;
		text-transform: uppercase;
		font-weight: 700;
	}

	.modal-header h3 {
	  margin-top: 0;
	  color: #FFF;
	}

	.modal-body {
	  margin: 20px 0;
	}

	.modal_inputs {
		display: flex;
		flex-direction: column;
		color: #fff;
	}

	/*
	 * The following styles are auto-applied to elements with
	 * transition="modal" when their visibility is toggled
	 * by Vue.js.
	 *
	 * You can easily play with the modal transition by editing
	 * these styles.
	 */

	.modal-enter {
	  opacity: 0;
	}

	.modal-leave-active {
	  opacity: 0;
	}

	.modal-enter .modal-container,
	.modal-leave-active .modal-container {
	  -webkit-transform: scale(1.1);
	  transform: scale(1.1);
	}
</style>