<template>
  <v-app-bar color="deep-purple" dense dark app>
    <v-toolbar-title>Banco de Tiempo</v-toolbar-title>
    <v-spacer></v-spacer>

    <v-btn @click="login" color="primary" class="mr-2">Iniciar Sesión</v-btn>
    <v-btn @click="sign_up" color="secondary">Crear Cuenta</v-btn>
  </v-app-bar>
</template>

<script>
export default {
  methods: {
    login() {
      this.$router.push({ name: "login" });
    },
    sign_up() {
      this.$router.push({ name: "sign_up" });
    },
  },
};
</script>

<style scoped>
</style>