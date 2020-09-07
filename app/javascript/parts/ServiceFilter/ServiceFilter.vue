
<template>
  <div id="service_filter" class="container border rounded pt-2 pb-2 mb-3">
    <form :action="$servicesPath" method="GET">
      <div class="d-flex align-items-center border-bottom mb-2 justify-content-between">
        <h4 class="mb-0">Filtros</h4>
        <button type="submit" class="apply_filters btn btn-primary btn-sm">Aplicar filtros</button>
      </div>
      <Searcher
        placeholder="Categorías"
        search_string="category_filter"
        :field_name="category_search_string"
        :search_url="$getJsonCategoriesPath"
        :initialValue="initialValue"
        :dataRetriveCallback="categoriesCallback"
      />
      <Searcher
        placeholder="Categoría Raiz"
        field_name="filter_supcategory"
        :search_url="$getJsonCategoriesPath"
        :dataRetriveCallback="supcategoriesCallback"
      />
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
    };
  },
  computed: {
    initialValue() {
      const params = new URLSearchParams(window.location.search);
      return params.get(this.category_search_string);
    },
  },
  methods: {
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
