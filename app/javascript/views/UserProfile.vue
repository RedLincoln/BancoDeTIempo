<template>
  <v-container>
    <v-row>
      <v-col cols="3">
        <v-img :src="avatar" max-width="100%"> </v-img>
      </v-col>
      <v-col cols="9">
        <v-card>
          <v-card-title>
            {{ name }}
          </v-card-title>

          <v-card-text class="headline font-weight-bold">
            {{ information }}
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
          :items="services"
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
      <v-tab-item></v-tab-item>
    </v-tabs-items>
  </v-container>
</template>

<script>
import UserService from "../services/user";
import defaultAvatar from "images/default-avatar.jpg";

const { getUser } = UserService;

export default {
  props: ["id"],
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
      avatar: "",
      name: "",
      information: "",
      services: [],
    };
  },
  created() {
    getUser(this.id).then((user) => {
      this.avatar = !!user.avatar ? user.avatar : defaultAvatar;
      this.name = user.name;
      this.information = user.information;
      this.services = user.services;
    });
  },
};
</script>

<style></style>
