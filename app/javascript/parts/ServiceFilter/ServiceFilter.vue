
<template>
  <div id="service_filter">
    <input
      type="text"
      name="filter_category"
      placeholder="Categoría"
      v-model="categoryInput"
      @blur="hideCategory"
      @focus="showCategory"
      @input="getCategoriesOnInput"
    />
    <ul v-if="showCategoriesFilter" class="categories_list">
      <li
        v-for="(category, index) in categories"
        :key="index"
        @click="setCategoryFilter(category)"
      >{{ category }}</li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";

const waitTime = 2000;
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
      if (this.showCategoriesFilter) this.getCategories();
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
        this.getCategories();
      }, waitTime);
    },
    getCategories() {
      axios
        .get(this.$getJsonCategoriesPath, {
          category_filter: this.categoryInput,
        })
        .then((response) => {
          this.categories = response.data.map((category) => category.name);
        });
    },
  },
};
</script>

<style scoped>
</style>
