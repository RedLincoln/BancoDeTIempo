<template>
  <v-data-table
    :headers="headers"
    :items="petitions"
    :items-per-page="10"
    class="elevation-1"
    :search="search"
  >
    <template v-slot:top>
      <v-text-field v-model="search" label="Buscar Petición" class="mx-4">
      </v-text-field>
    </template>
    <template v-slot:item.name="{ item }">
      <router-link
        v-if="loggedIn"
        :to="{ name: 'service-profile', params: { id: item.service.id } }"
        >{{ item.name }}
      </router-link>
      <span v-else>{{ item.name }}</span>
    </template>
    <template v-slot:item.owner="{ item }">
      <router-link
        v-if="loggedIn"
        :to="{ name: 'user-profile', params: { id: item.owner.id } }"
        >{{ item.owner.name }}
      </router-link>
      <span v-else>{{ item.owner.name }}</span>
    </template>
    <template v-slot:item.client="{ item }">
      <router-link
        v-if="loggedIn"
        :to="{ name: 'user-profile', params: { id: item.client.id } }"
        >{{ item.client.name }}
      </router-link>
      <span v-else>{{ item.client.name }}</span>
    </template>
  </v-data-table>
</template>

<script>
import { mapState } from "vuex";

export default {
  props: {
    petitions: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      search: "",
      headers: [
        {
          text: "Nombre de Servicio",
          align: "start",
          sortable: false,
          value: "name",
        },
        { text: "Usuario que lo realiza", align: "start", value: "owner" },
        { text: "Usuario que lo recibe", align: "start", value: "client" },
        { text: "Información", value: "additional_information" },
        { text: "Fechar y Hora" },
      ],
    };
  },
  computed: mapState("session", ["loggedIn"]),
};
</script>

<style></style>
