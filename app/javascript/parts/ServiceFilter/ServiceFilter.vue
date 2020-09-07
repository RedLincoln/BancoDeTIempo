
<template>
  <div id="service_filter" class="container border rounded pt-2 pb-2 mb-3">
    <form :action="$servicesPath" method="GET">
      <div class="d-flex align-items-center border-bottom mb-2 justify-content-between">
        <h4 class="mb-0 filter-dropdown">Filtros</h4>
        <button
          v-if="show"
          type="submit"
          class="apply_filters btn btn-primary btn-sm"
        >Aplicar filtros</button>
      </div>
      <div v-if="show" class="dropdown-content">
        <Searcher
          placeholder="Categorías"
          search_string="category_filter"
          :field_name="category_search_string"
          :search_url="$getJsonCategoriesPath"
          :initialValue="categoryInitialValue"
          :dataRetriveCallback="categoriesCallback"
        />
        <Searcher
          placeholder="Categoría Raiz"
          search_string="supcategory_filter"
          :field_name="supcategory_search_string"
          :search_url="$getJsonCategoriesPath"
          :initialValue="supcategoryInitialValue"
          :dataRetriveCallback="supcategoriesCallback"
        />
      </div>
    </form>
  </div>
</template>

<script>
import Searcher from "../shared/Searcher/Searcher";

export default {
  components: {
    Searcher,
  },
  data: function () {
    return {
      category_search_string: "filter_category",
      supcategory_search_string: "filter_supcategory",
    };
  },
  computed: {
    categoryInitialValue() {
      const params = new URLSearchParams(window.location.search);
      return params.get(this.category_search_string);
    },
    supcategoryInitialValue() {
      const params = new URLSearchParams(window.location.search);
      return params.get(this.supcategory_search_string);
    },
  },
  methods: {
    setSupcategory(supcategoryValue) {
      this.supcategoryValue = supcategoryValue;
    },
    categoriesCallback(response) {
      return response.data.map((category) => category.name);
    },
    supcategoriesCallback(response) {
      return [
        ...new Set(response.data.map((category) => category.supcategory)),
      ];
    },
  },
};
</script>

<style scoped>
</style>
