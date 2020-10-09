<template>
  <v-app-bar color="deep-purple" dark app>
    <router-link :to="{ name: 'home' }">
      <Logo />
    </router-link>
    <v-spacer></v-spacer>

    <template v-if="!loggedIn">
      <v-btn
        :to="{ name: 'login' }"
        color="primary"
        class="mr-2"
        data-testid="login-btn"
        >Iniciar Sesión</v-btn
      >
      <v-btn
        :to="{ name: 'sign_up' }"
        color="secondary"
        data-testid="sign_up-btn"
        >Crear Cuenta</v-btn
      >
    </template>
    <template v-else>
      <v-avatar class="avatar">
        <img :src="avatarUrl" alt="avatar" />
      </v-avatar>
    </template>
  </v-app-bar>
</template>

<script>
import { mapState } from "vuex";
import defaultAvatar from "images/default-avatar.jpg";

export default {
  data() {
    return {
      avatarUrl: null,
    };
  },
  computed: mapState("session", ["loggedIn", "avatar"]),
  created() {
    console.log(this.loggedIn);
    this.avatarUrl = !!this.avatar ? this.avatar : defaultAvatar;
  },
};
</script>
