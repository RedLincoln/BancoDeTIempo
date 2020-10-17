<template>
  <v-toolbar flat>
    <v-tabs show-arrows optional>
      <template v-if="loggedIn && role === 'admin'">
        <v-tab>
          <v-btn
            data-testid="admin-users-tab"
            :to="{ name: 'admin-users' }"
            text
            >Gestionar Usuarios</v-btn
          >
        </v-tab>
      </template>
      <v-tab>
        <v-btn :to="{ name: 'users' }" text>Miembros</v-btn>
      </v-tab>
      <v-tab>
        <v-btn :to="{ name: 'services' }" text>Servicios Ofertados</v-btn>
      </v-tab>
      <v-tab>
        <v-btn :to="{ name: 'petitions' }" text>Peticiones de servicios</v-btn>
      </v-tab>
    </v-tabs>
  </v-toolbar>
</template>

<script>
import { mapState } from "vuex";

export default {
  computed: mapState("session", ["loggedIn", "role"]),
};
</script>

<style></style>
