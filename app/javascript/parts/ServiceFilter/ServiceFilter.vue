
<template>
  <div id="service_filter">
    <input type="text" name="filter_category" placeholder="Categoría" @focus="getCategories" />
    <ul v-if="showCategoriesFilter" class="categories_list">
      <li v-for="(category, index) in categories" :key="index">{{ category }}</li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data: function () {
    return {
      showCategoriesFilter: false,
      categories: [],
    };
  },
  methods: {
    getCategories() {
      this.showCategoriesFilter = true;
      axios.get(this.$getJsonCategoriesPath).then((response) => {
        this.categories = response.data.map((category) => category.name);
      });
    },
  },
};
</script>

<style scoped>
</style>
