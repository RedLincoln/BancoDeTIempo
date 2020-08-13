
<template>
  <div id="session_actions">
    <template v-if="isLogged">
      <p class="user_name">{{ user_name }}</p>
      <a class="logout_button">Cerrar sesión</a>
    </template>
    <template v-else>
      <a class="login_button">Iniciar sesión</a>
      <a class="sign_up_button">Registrarse</a>
    </template>
  </div>
</template>

<script>
// import store from '@/store'
export default {
  props: ['isLogged', 'user_name'],
  data: function() {
    return {

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
