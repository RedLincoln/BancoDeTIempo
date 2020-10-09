<template>
  <v-toolbar flat>
    <template v-if="loggedIn">
      <v-btn
        v-if="role === 'admin'"
        data-testid="admin-users-tab"
        :to="{ name: 'admin-users' }"
        text
        >Gestionar Usuarios</v-btn
      >
    </template>
  </v-toolbar>
</template>

<script>
import { mapState } from "vuex";

export default {
  computed: mapState("session", ["loggedIn", "role"]),
};
</script>

<style>
</style>