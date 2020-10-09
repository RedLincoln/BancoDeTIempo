<template>
  <v-app-bar color="deep-purple" dense dark app>
    <v-toolbar-title>Banco de Tiempo</v-toolbar-title>
    <v-spacer></v-spacer>

    <v-btn
      :to="{ name: 'login' }"
      color="primary"
      class="mr-2"
      data-testid="login-btn"
      >Iniciar Sesión</v-btn
    >
    <v-btn :to="{ name: 'sign_up' }" color="secondary" data-testid="sign_up-btn"
      >Crear Cuenta</v-btn
    >
  </v-app-bar>
</template>
