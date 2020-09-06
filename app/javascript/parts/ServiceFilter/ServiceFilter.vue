
<template>
  <div id="service_filter">
    <form :action="$getJsonCategoriesPath" method="GET">
      <input type="text" name="filter_category" placeholder="Categoría" />
    </form>
  </div>
</template>

<script>
export default {
  data: function () {
    return {};
  },
};
</script>

<style scoped>
</style>
