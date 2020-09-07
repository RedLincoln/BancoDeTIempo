
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
        field_name="filter_category"
        :search_url="$getJsonCategoriesPath"
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
    return {};
  },
};
</script>

<style scoped>
</style>
