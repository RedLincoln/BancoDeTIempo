
<template>
  <div id="session_actions">
    <template v-if="isLoggedReactive">
      <p class="user_name">{{ user_name }}</p>
      <Link class="logout_button" text="Cerrar sesión" :isNotAnAnchor="true" @click.native="logout"/>
    </template>
    <template v-else>
      <Link class="login_button" text="Iniciar sesión" :href="loginPath"/>
      <Link class="sign_up_button" text="Registrarse" :href="signUpPath"/>
    </template>
  </div>
</template>

<script>
import Link from './Link/link'
import Route from '../routes'
import axios from 'axios'

export default {
  components: {Link},
  props: ['isLogged', 'user_name'],
  data: function() {
    return {
      isLoggedReactive: this.isLogged,
      loginPath: Route.new_user_session_path(),
      signUpPath: Route.new_user_registration_path()
    };
  },
  methods: {
    logout: function () {
      const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      axios.delete(Route.destroy_user_session_path({ format: 'json'}),
              {
                headers: {
                  'X-CSRF-Token': csrfToken
                }
              }
      ).then(response => this.isLoggedReactive = false).catch(err => console.log(Route.destroy_user_session_path()))
    }
  }
};
</script>

<style scoped>

</style>
