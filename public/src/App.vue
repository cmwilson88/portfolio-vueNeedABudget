<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
  import Home from './components/Home/Home.vue'
  import BudgetHome from './components/Budgets/BudgetHome.vue'

  export default {
    data () {
      return {}
    },
    components: {
      appHome: Home,
      appBudgetHome: BudgetHome
    }
  }
</script>

<style>

</style>
