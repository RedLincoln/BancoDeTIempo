<template>
  <div>
    <BaseCenter>
      <BaseSearchField
        v-model="search"
        placeholder="Buscar Servicio"
        @search="fetchServices"
      ></BaseSearchField>
      <BaseTools>
        <v-row>
          <v-col cols="6">
            <BaseSelect
              :items="categories"
              item-text="name"
              @change="selectedCategory = $event"
              label="Filtrar Por Categoría"
              clearable
            />
          </v-col>
          <v-col cols="6">
            <BaseSelect
              :items="orderList"
              item-text="key"
              @change="sortOrder = $event"
              label="Ordenar"
            />
          </v-col>
        </v-row>
      </BaseTools>
    </BaseCenter>
    <v-pagination
      @input="navigateToPage"
      v-model="page"
      :length="totalPages"
    ></v-pagination>
    <p class="text-center">{{ first }}-{{ last }} de {{ totalServices }}</p>
    <v-simple-table class="m-5 elevation-2">
      <thead dark>
        <tr>
          <th>Nombre del Servicio</th>
          <th>Categoría</th>
          <th>Propietario</th>
          <th>Descripción</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(service, index) in services" :key="index">
          <td>
            <router-link
              :to="{ name: 'service-profile', params: { id: service.id } }"
              >{{ service.name }}</router-link
            >
          </td>
          <td>{{ service.category }}</td>
          <td>
            <router-link
              :to="{ name: 'user-profile', params: { id: service.owner.id } }"
              >{{ service.owner.name }}</router-link
            >
          </td>
          <td>{{ service.description }}</td>
        </tr>
      </tbody>
    </v-simple-table>
    <v-pagination
      @input="navigateToPage"
      v-model="page"
      :length="totalPages"
    ></v-pagination>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  data() {
    return {
      search: "",
      page: 1,
      service_type: "",
      selectedCategory: undefined,
      sortOrder: { key: "Sin Orden", value: "updated_at" },
      orderList: [
        { key: "Sin Orden", value: "updated_at" },
        { key: "Categoría", value: "category" },
        { key: "Propietario", value: "owner_name" },
      ],
    };
  },
  computed: {
    first() {
      return 1 + (this.page - 1) * this.perPage;
    },
    last() {
      return this.first + this.services.length - 1;
    },
    totalPages() {
      return Math.ceil(this.totalServices / this.perPage);
    },
    ...mapState("services", [
      "services",
      "totalServices",
      "perPage",
      "categories",
    ]),
  },
  watch: {
    sortOrder(val) {
      this.fetchServices();
    },
    selectedCategory(val) {
      this.fetchServices();
    },
  },
  created() {
    this.setServiceType();
    this.setPage();
    this.fetchServices();
  },
  methods: {
    navigateToPage(page) {
      this.$router.push({
        name: "services",
        query: { service_type: this.service_type, page: page },
      });
    },
    setServiceType() {
      this.service_type = this.$route.query.service_type;
    },
    setPage() {
      const page = this.$route.query.page;
      if (page && Number.isInteger(parseInt(page))) {
        this.page = parseInt(page);
      }
    },
    fetchServices() {
      this.$store.dispatch("services/fetch", {
        page: this.page - 1,
        q: this.search,
        service_type: this.service_type,
        sort_order: this.sortOrder.value,
        category: !!this.selectedCategory ? this.selectedCategory.name : "",
      });
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
