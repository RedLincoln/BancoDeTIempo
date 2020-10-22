<template>
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
    <template v-slot:item.name="{ item }">
      {{ item.name }}
      <router-link
        v-if="userIsLoggedIn"
        :to="{ name: 'service-edit', params: { id: item.id } }"
        ><v-chip>Editar</v-chip></router-link
      >
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
</template>

<script>
export default {
  props: {
    services: {
      type: Array,
      required: true,
    },
    userIsLoggedIn: {
      type: Boolean,
      default: false,
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
        { text: "Categoría", value: "category" },
        { text: "Descripción", value: "description" },
      ],
    };
  },
};
</script>

<style></style>
