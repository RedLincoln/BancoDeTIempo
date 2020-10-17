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
    <template v-slot:item.status="{ item }">
      <v-chip>{{ formatStatus(item.status) }}</v-chip>
    </template>
    <template v-slot:item.datetime="{ item }">
      <p :class="durationColor(item)" class="m-0">{{ item.duration }} horas</p>
      <p class="m-0">{{ item.datetime }}</p>
    </template>
    <template v-slot:item.name="{ item }">
      <router-link
        v-if="loggedIn"
        :to="{ name: 'service-profile', params: { id: item.service.id } }"
        >{{ item.service.name }}
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
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      search: "",
      headers: [
        { text: "Estado del la petición", value: "status", align: "center" },
        {
          text: "Nombre de Servicio",
          align: "start",
          sortable: false,
          value: "name",
        },
        { text: "Fechar, Hora y Duración", value: "datetime", align: "center" },
        { text: "Propietario", align: "start", value: "owner" },
        { text: "Client", align: "start", value: "client" },
        { text: "Información", value: "additional_information" },
      ],
    };
  },
  computed: mapState("session", ["loggedIn", "user_id"]),
  methods: {
    durationColor(petition) {
      return petition.is_client ? "red--text" : "green--text";
    },
    formatStatus(status) {
      switch (status) {
        case "negotiating":
          return "Negociación";
        case "accepted":
          return "Aceptada";
        case "canceled":
          return "Cancelada";
        case "done":
          return "Realizada";
        case "valued":
          return "Valorada";
      }
    },
  },
};
</script>

<style></style>
