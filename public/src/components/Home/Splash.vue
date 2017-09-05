<template>
	<div>
		<div class="splash_banner">
				<h1 class="site_title">VUE NEED A BUDGET</h1>
				<a class="login_btn btn" href="http://165.227.99.251:3000/auth/callback"><span class="header_inner_btn">Log In</span></a>
		</div>
		<transition-group name="fade" mode="out-in">
			<div class="vue_splash" key="logo" v-if="showLogo">
				<img src="../../assets/vuejs.png" alt="VueJS Logo" class="main_logo" @click="showLogo = false">
			</div>
			<div class="tech_used_wrapper" key="tech" v-else>
				<div class="tech_used">
					<img src="../../assets/vuejs.png" alt="vuejs" class="tech" @click="showLogo = true">
					<img src="../../assets/vuex.png" alt="vuex" class="tech" @click="showLogo = true">
					<img src="../../assets/vue-router.png" alt="vue-router" class="tech" @click="showLogo = true">
					<img src="../../assets/nodejs.png" alt="nodejs" class="tech" @click="showLogo = true">
					<img src="../../assets/postgresql.png" alt="postgres" class="tech" @click="showLogo = true">
					<img src="../../assets/html5-css3-js.png" alt="basics" class="tech" @click="showLogo = true">
				</div>
			</div>
		</transition-group>
		<div class="fullscreen_bg">
				<video loop muted autoplay class="fullscreen-bg_video">
					<source src="https://d1235ca2z646oc.cloudfront.net/videos/processed/1716/Northernlights2_HD.mp4.mp4" type="video/mp4">
				</video>
		</div>
	</div>
</template>

<script>
	import {mapGetters, mapActions} from 'vuex'
	export default {
		data() {
			return {
				showLogo: true
			}
		},
		computed: {
			...mapGetters(['month', 'year'])
		},
		methods: {
			...mapActions(['getToday']),
			goToBudget() {
				this.$router.push('/app/budget/1/' + this.month + '/' + this.year)
			},
			goToAuth() {

			}
		},
		created() {
			this.getToday();
		}
	}
</script>

<style>
	.fade-enter {
        opacity: 0;
    }

    .fade-enter-active {
        transition: opacity 1s;
    }

    .fade-leave {
        /*opacity: 1;*/
    }

    .fade-leave-active {
        transition: opacity 1s;
        opacity: 0;
    }

	.fullscreen_bg {
		position:fixed;
		top: 0;
		bottom: 0;
		left: 0;
		right: 0;
		z-index: -1000;
	}

	.fullscreen-bg_video {
		position: fixed;
		top: 50%;
		left: 50%;
		width: auto;
		height: auto;
		min-width: 100%;
		min-height: 100%;
		transform: translate(-50%, -50%);
	}

	.splash_banner {
		display: flex;
		justify-content: space-around;
		align-items: center;
		height: 100px;
	}

	.login_btn {
		color: #fff;
		font-weight: 700;
		font-size: 24px;
		padding: 15px 25px;
		background-color: #4FC08D;
		border-radius: 15px;
		cursor: pointer;

		z-index: 999;
	}


	.vue_splash {
		display: flex;
		justify-content: center;
		align-items: center;
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		z-index: -1;
	}

	.main_logo {
		width: 50%;
		height: auto;
		filter: drop-shadow(5px 5px 10px #222);
	}


	.site_title {
		color: #fff;
		font-size: 40px;
		font-weight: 900;
	}

	.tech_used_wrapper {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 80vh;
	}

	.tech_used {
	  display: grid;
	  grid-template-columns: repeat(3, 1fr);
	  grid-gap: 50px;
	  grid-auto-rows: minmax(100px, auto);
	  align-items: center;
	  justify-items: center;
	  padding-bottom: 50px;
	}

	.tech {
		height: 200px;
		width: 200px;
	}

	@media(max-width: 767px) {
		.fullscreen-bg {
			background: url('../../assets/firstframe.png') center center / cover no-repeat;
		}

		.fullscreen-bg_video {
			display: none;
		}
	}
</style>
