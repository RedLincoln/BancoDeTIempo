<template>
  <v-data-table
    :headers="headers"
    :items="filteredServices"
    :items-per-page="itemsPerPage"
    :page.sync="page"
    hide-default-footer
    class="elevation-1"
    :search="search"
    @page-count="pageCount = $event"
  >
    <template v-slot:top>
      <v-row justify="center">
        <v-col cols="8" md="6">
          <v-text-field
            prepend-inner-icon="mdi-magnify"
            v-model="search"
            placeholder="Buscar Servicio"
            filled
            rounded
          ></v-text-field>
          <v-btn text @click="tools = !tools"
            ><v-icon>mdi-tools</v-icon>Herramientas</v-btn
          >
          <v-scroll-y-transition>
            <v-sheet v-if="tools">
              <v-text-field
                v-model="categoryFilter"
                placeholder="Filtrar Categoría"
                solo
                clearable
                @keyup="filterByCategory"
                @click:clear="filterByCategory"
              ></v-text-field>
            </v-sheet>
          </v-scroll-y-transition>
        </v-col>
      </v-row>
      <v-pagination v-model="page" :length="pageCount"></v-pagination>
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
    <template v-slot:item.category="{ item }">
      {{ item.category }}
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
      categoryFilter: "",
      lastCategoryFilter: "",
      filteredServices: this.services,
      tools: false,
      categoryFilter: "",
      page: 1,
      itemsPerPage: 10,
      pageCount: 0,
      search: "",
      headers: [
        {
          text: "Nombre de Servicio",
          align: "start",
          sortable: false,
          value: "name",
        },
        { text: "Propietario", align: "start", value: "owner" },
        { text: "Categoría", value: "category" },
        { text: "Descripción", value: "description" },
      ],
    };
  },
  computed: {
    ...mapState("session", ["loggedIn"]),
  },
  created() {
    this.categoryFilter = !!this.$route.query.category
      ? !!this.$route.query.category
      : "";
    this.filterByCategoryInput(this.categoryFilter);
  },
  methods: {
    filterByCategoryInput(input) {
      const toFilter =
        input.length > this.lastCategoryFilter.length
          ? this.filteredServices
          : this.services;
      this.filteredServices = toFilter.filter((service) =>
        service.category.toLowerCase().includes(input.toLowerCase())
      );
      this.lastCategoryFilter = input;
    },
    filterByCategory(event) {
      const input = event.target.value;
      this.filterByCategoryInput(input);
    },
  },
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
