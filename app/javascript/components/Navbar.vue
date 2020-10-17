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
      <Notifications class="mr-3" />
      <v-chip class="mr-3" :color="balanceColor" text-color="white">
        <v-icon left>
          mdi-cash-multiple
        </v-icon>
        {{ balance }}
      </v-chip>
      <UserMenu />
    </template>
  </v-app-bar>
</template>

<script>
import Notifications from "./Notifications";
import UserMenu from "./UserMenu";
import { mapState } from "vuex";

export default {
  components: {
    Notifications,
    UserMenu,
  },
  computed: {
    balanceColor() {
      return this.user_balance > 0 ? "green" : "red";
    },
    balance() {
      return this.user_balance >= 0
        ? `${this.user_balance} horas`
        : `-${this.user_balance} horas`;
    },
    ...mapState("session", ["loggedIn", "user_balance"]),
  },
};
</script>
