
<template>
  <div id="session_actions">
    <template v-if="isLoggedReactive">
      <p class="user_name">{{ user_name }}</p>
      <Link class="logout_button" text="Cerrar sesión" :isNotAnAnchor="true" @click.native="logout"/>
    </template>
    <template v-else>
      <Link class="login_button" text="Iniciar sesión" :href="$loginPath"/>
      <Link class="sign_up_button" text="Registrarse" :href="$signUpPath"/>
    </template>
  </div>
</template>

<script>
import Link from './Link/Link'
import axios from 'axios'

export default {
  components: {Link},
  props: ['isLogged', 'user_name'],
  data: function() {
    return {
      isLoggedReactive: this.isLogged
    };
  },
  methods: {
    logout: function () {
      axios.delete(this.$signOutPath,{headers: { 'X-CSRF-Token': this.$getCSRFToken() }}
      ).then(response => this.isLoggedReactive = false).catch(err => console.log(err))
    }
  }
};
</script>

<style scoped>

</style>
