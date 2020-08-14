
<template>
  <div id="session_actions">
    <template v-if="isLogged">
      <p class="user_name">{{ user_name }}</p>
      <Link class="logout_button" text="Cerrar sesión" :href="logoutPath"/>
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

export default {
  components: {Link},
  props: ['isLogged', 'user_name'],
  comments:{
    Link
  },
  data: function() {
    return {
      loginPath: Route.new_user_session_path(),
      logoutPath: Route.destroy_user_session_path(),
      signUpPath: Route.new_user_registration_path()
    };
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
