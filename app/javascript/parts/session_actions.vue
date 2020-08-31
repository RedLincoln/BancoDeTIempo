
<template>
  <div id="session_actions" class="d-flex align-items-center">
    <template v-if="isLoggedReactive">
      <NavigationDropdown :title="user_name" :links="getLinks()"/>
      <Link class="logout_button btn btn-danger" text="Cerrar sesión" :isNotAnAnchor="true" @click.native="logout"/>
    </template>
    <template v-else>
      <Link class="login_button btn btn-info" text="Iniciar sesión" :href="$loginPath"/>
      <Link class="sign_up_button btn btn-light" text="Registrarse" :href="$signUpPath"/>
    </template>
  </div>
</template>

<script>
import Link from './Link/Link'
import NavigationDropdown from './navigation_dropdown'
import axios from 'axios'
import axiosConf from '../setupAxios'

export default {
  components: {Link, NavigationDropdown},
  props: ['isLogged', 'user_name'],
  data: function() {
    return {
      isLoggedReactive: this.isLogged
    };
  },
  methods: {
    logout: function () {
      axios.delete(this.$signOutPath, {headers: axiosConf.getDefaultHeader()})
              .then(response => {
                this.isLoggedReactive = false
                Turbolinks.visit('/')
              }).catch(err => console.log(err))
    },
    getLinks: function () {
      return [
        {href: this.$userProfilePath, text: 'Perfil'},
        {href: this.$userServicesPath, text: 'Mis servicios'}
      ]
    }
  }
};
</script>

<style scoped>

</style>
