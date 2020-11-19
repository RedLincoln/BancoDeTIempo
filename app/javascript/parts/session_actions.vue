<template>
  <div
    v-if="isLoggedReactive"
    id="session_actions"
    class="row justify-content-between pr-2"
  >
    <Notifications
      class="align-self-center col-1"
      :user_id="user_id"
    ></Notifications>
    <NavigationDropdown class="col-4" :title="user_name" :links="getLinks()" />
    <Link
      class="logout_button btn btn-danger text-white col-6"
      text="Cerrar sesión"
      :isNotAnAnchor="true"
      @click.native="logout"
    />
  </div>
  <div v-else id="session_actions" class="justify-content-between">
    <Link
      class="login_button btn btn-info text-white"
      text="Iniciar sesión"
      :href="$loginPath"
    />
    <Link
      class="sign_up_button btn btn-light"
      text="Registrarse"
      :href="$signUpPath"
    />
  </div>
</template>

<script>
import Link from "./Link/Link";
import NavigationDropdown from "./navigation_dropdown";
import Notifications from "./notifications";
import axios from "axios";
import axiosConf from "../setupAxios";

export default {
  components: { Link, NavigationDropdown, Notifications },
  props: ["isLogged", "user_name", "user_id"],
  data: function() {
    return {
      isLoggedReactive: this.isLogged,
    };
  },
  methods: {
    logout: function() {
      axios
        .delete(this.$signOutPath, { headers: axiosConf.getDefaultHeader() })
        .then((response) => {
          Turbolinks.visit("/");
        })
        .catch((err) => console.log(err));
    },
    getLinks: function() {
      return [
        { href: this.$userProfilePath, text: "Perfil" },
        { href: this.$userServicesPath, text: "Mis servicios" },
        { href: this.$userAccountPath, text: "Mi cuenta" },
      ];
    },
  },
};
</script>

<style scoped></style>
