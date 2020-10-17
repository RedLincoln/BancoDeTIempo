<template>
  <v-container>
    <v-row>
      <v-col cols="3">
        <v-img :src="user.avatar" max-width="100%"> </v-img>
      </v-col>
      <v-col cols="9">
        <v-card>
          <v-card-title>
            {{ user.name }}
          </v-card-title>

          <v-card-text class="headline font-weight-bold">
            {{ user.information }}
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    <v-tabs v-model="tab">
      <v-tab>Servicios Ofertando</v-tab>
      <v-tab>Servicios Demandando</v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <v-tab-item>
        <v-data-table
          :headers="headers"
          :items="servicesOffering"
          :items-per-page="5"
          class="elevation-1"
          :search="search"
        >
          <template v-slot:top>
            <v-text-field v-model="search" label="Buscar Servicio" class="mx-4">
            </v-text-field>
          </template>
          <template v-slot:item.category="{ item }">
            <router-link
              :to="{
                name: 'services',
                query: { category: item.category.name },
              }"
              >{{ item.category.name }}</router-link
            >
          </template>
        </v-data-table>
      </v-tab-item>
      <v-tab-item>
        <v-data-table
          :headers="headers"
          :items="servicesDemanding"
          :items-per-page="5"
          class="elevation-1"
          :search="search"
        >
          <template v-slot:top>
            <v-text-field v-model="search" label="Buscar Servicio" class="mx-4">
            </v-text-field>
          </template>
        </v-data-table>
      </v-tab-item>
    </v-tabs-items>
  </v-container>
</template>

<script>
import UserService from "../services/user";
import defaultAvatar from "images/default-avatar.jpg";

const { getUser } = UserService;

export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
    services: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      tab: null,
      search: "",
      headers: [
        {
          text: "Nombre de Servicio",
          align: "start",
          sortable: false,
          value: "name",
        },
        { text: "Categoría", value: "category" },
        { text: "Descripción", value: "description" },
      ],
    };
  },
  computed: {
    servicesDemanding() {
      return this.services.filter(
        (service) => service.service_type === "demand"
      );
    },
    servicesOffering() {
      return this.services.filter(
        (service) => service.service_type === "offer"
      );
    },
  },
};
</script>

<style></style>
