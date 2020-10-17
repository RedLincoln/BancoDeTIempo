<template>
  <v-data-table
    :headers="headers"
    :items="services"
    :items-per-page="15"
    class="elevation-1"
    :search="search"
  >
    <template v-slot:top>
      <v-text-field v-model="search" label="Buscar Servicio" class="mx-4">
      </v-text-field>
    </template>
    <template v-slot:item.name="{ item }">
      <router-link
        v-if="loggedIn"
        :to="{ name: 'service-profile', params: { id: item.id } }"
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
  </v-data-table>
</template>

<script>
import { mapState } from "vuex";

export default {
  props: {
    services: {
      type: Array,
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
        { text: "Usuario que lo ofrece", align: "start", value: "owner" },
        { text: "Categoría", value: "category" },
        { text: "Descripción", value: "description" },
      ],
    };
  },
  computed: mapState("session", ["loggedIn"]),
};
</script>

<style scoped>
th {
  font-size: 1.1rem !important;
}

td {
  font-size: 1rem !important;
}
</style>
