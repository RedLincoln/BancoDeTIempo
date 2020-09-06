
<template>
  <div id="service_filter" class="container border rounded pt-2 pb-2 mb-3">
    <form :action="$servicesPath" method="GET">
      <div class="d-flex align-items-center border-bottom mb-2 justify-content-between">
        <h4 class="mb-0">Filtros</h4>
        <button type="submit" class="apply_filters btn btn-primary btn-sm">Aplicar filtros</button>
      </div>
      <div>
        <input
          type="text"
          name="filter_category"
          placeholder="Categoría"
          v-model="categoryInput"
          @focus="showCategory"
          @input="getCategoriesOnInput"
        />
        <span v-if="showCategoriesFilter"
              class="close_filter one-letter-square border rounded-circle bg-secondary text-light"
              @click="hideCategory">
          x
        </span>
      </div>
    </form>
    <ul v-if="showCategoriesFilter" class="categories_list list-group">
      <li class="list-group-item list-group-item-action"
        v-for="(category, index) in categories"
        :key="index"
        @click="setCategoryFilter(category)"
      >{{ category }}</li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";
import railsFlash from "../../railsFlash";

const waitTime = 300;
let inputTimeout = null;

export default {
  data: function () {
    return {
      categoryInput: "",
      showCategoriesFilter: false,
      categories: [],
    };
  },
  watch: {
    showCategoriesFilter() {
      if (this.showCategoriesFilter) this.filterCategories('');
    },
  },
  methods: {
    setCategoryFilter(categoryName) {
      this.categoryInput = categoryName;
    },
    hideCategory() {
      this.showCategoriesFilter = false;
    },
    showCategory() {
      this.showCategoriesFilter = true;
    },
    getCategoriesOnInput() {
      clearTimeout(inputTimeout);
      inputTimeout = setTimeout(() => {
        this.filterCategories(this.categoryInput);
      }, waitTime);
    },
    filterCategories(search_string) {
      axios
        .get(this.$getJsonCategoriesPath, {
          params: {
            category_filter: search_string,
          },
        })
        .then((response) => {
          this.categories = response.data.map((category) => category.name);
        })
        .catch((err) => {
          railsFlash.alert("Error al buscar categorías");
        });
    },
  },
};
</script>

<style scoped>

</style>
