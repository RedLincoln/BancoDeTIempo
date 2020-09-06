
<template>
  <div id="service_filter">
    <input type="text" name="filter_category" placeholder="Categoría" @focus="getCategories" />
    <ul class="categories_list">
      <li v-for="(category, index) in categories" :key="index">{{ category }}</li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data: function () {
    return {
      categories: "",
    };
  },
  methods: {
    getCategories() {
      axios.get(this.$getJsonCategoriesPath).then((response) => {
        this.categories = response.data.map((category) => category.name);
      });
    },
  },
};
</script>

<style scoped>
</style>
