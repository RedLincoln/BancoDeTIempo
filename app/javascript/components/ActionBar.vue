<template>
  <v-toolbar flat>
    <v-tabs show-arrows optional>
      <template v-if="loggedIn && role === 'admin'">
        <v-tab>
          <v-btn
            exact
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
        <v-btn
          :to="{ name: 'services', query: { service_type: 'offer', page: 1 } }"
          text
          exact
          >Servicios Ofertados</v-btn
        >
      </v-tab>
      <v-tab>
        <v-btn
          :to="{ name: 'services', query: { service_type: 'demand' } }"
          text
          exact
          >Servicios Demandados</v-btn
        >
      </v-tab>
      <v-tab>
        <v-btn :to="{ name: 'petitions' }" text exact
          >Peticiones de servicios</v-btn
        >
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
