
<template>
  <div id="service_filter" class="border rounded p-3 mb-3">
    <form :action="$servicesPath" method="GET">
      <div class="d-flex align-items-center">
        <button
          @click="toggleFilters"
          type="button"
          class="btn filter-dropdown d-flex align-items-center border-bottom border-dark"
        >
          <svg
            width="1em"
            height="1em"
            viewBox="0 0 16 16"
            class="bi bi-tools"
            fill="currentColor"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              fill-rule="evenodd"
              d="M0 1l1-1 3.081 2.2a1 1 0 0 1 .419.815v.07a1 1 0 0 0 .293.708L10.5 9.5l.914-.305a1 1 0 0 1 1.023.242l3.356 3.356a1 1 0 0 1 0 1.414l-1.586 1.586a1 1 0 0 1-1.414 0l-3.356-3.356a1 1 0 0 1-.242-1.023L9.5 10.5 3.793 4.793a1 1 0 0 0-.707-.293h-.071a1 1 0 0 1-.814-.419L0 1zm11.354 9.646a.5.5 0 0 0-.708.708l3 3a.5.5 0 0 0 .708-.708l-3-3z"
            />
            <path
              fill-rule="evenodd"
              d="M15.898 2.223a3.003 3.003 0 0 1-3.679 3.674L5.878 12.15a3 3 0 1 1-2.027-2.027l6.252-6.341A3 3 0 0 1 13.778.1l-2.142 2.142L12 4l1.757.364 2.141-2.141zm-13.37 9.019L3.001 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026z"
            />
          </svg>
          <span class="mb-0 ml-2 font-weight-bold font-size-large">Filtros</span>
        </button>
      </div>
      <div v-if="show" class="dropdown-content mt-3">
        <div v-click-outside="hideCategory">
          <Searcher
            placeholder="Categorías"
            search_string="category_filter"
            :field_name="category_search_string"
            :search_url="$getJsonCategoriesPath"
            :initialValue="categoryInputValue"
            @send-response="updateCategories"
          />
          <ArrayListVisualizer
            class="mb-2 mt-2"
            @set-field-value="setCategoryInput"
            v-if="showCategory"
            :inputValues="categories"
          />
        </div>
        <div v-click-outside="hideSupcategory">
          <Searcher
            placeholder="Categoría Raiz"
            search_string="supcategory_filter"
            :field_name="supcategory_search_string"
            :search_url="$getJsonCategoriesPath"
            :initialValue="supcategoryInputValue"
            @send-response="updateSupcategories"
          />
          <ArrayListVisualizer
            @set-field-value="setSupcategoryInput"
            v-if="showSupcategory"
            :inputValues="supcategories"
          />
        </div>
      </div>
      <button
        v-if="show"
        type="submit"
        class="apply_filters btn btn-primary btn-sm mt-3"
      >Aplicar filtros</button>
    </form>
  </div>
</template>

<script>
import Searcher from "../shared/Searcher/Searcher";
import ArrayListVisualizer from "../shared/ArrayListVisualizer/ArrayListVisualizer";
import vClickOutside from "v-click-outside";

export default {
  directives: {
    clickOutside: vClickOutside.directive,
  },
  components: {
    Searcher,
    ArrayListVisualizer,
  },
  data: function () {
    return {
      showSupcategory: false,
      showCategory: false,
      show: false,
      categories: [],
      supcategories: [],
      categoryInputValue: "",
      supcategoryInputValue: "",
      category_search_string: "filter_category",
      supcategory_search_string: "filter_supcategory",
    };
  },
  mounted() {
    const params = new URLSearchParams(window.location.search);
    this.categoryInputValue = params.get(this.category_search_string);
    this.supcategoryInputValue = params.get(this.supcategory_search_string);
  },
  methods: {
    setCategoryInput(value) {
      this.categoryInputValue = value;
    },
    setSupcategoryInput(value) {
      this.supcategoryInputValue = value;
    },
    hideCategory() {
      this.showCategory = false;
    },
    hideSupcategory() {
      this.showSupcategory = false;
    },
    toggleFilters() {
      this.show = !this.show;
    },
    setSupcategory(supcategoryValue) {
      this.supcategoryValue = supcategoryValue;
    },
    updateCategories(response) {
      this.categories = response.data.map((category) => category.name);
      this.showCategory = true;
    },
    updateSupcategories(response) {
      this.supcategories = [
        ...new Set(response.data.map((category) => category.supcategory)),
      ];
      this.showSupcategory = true;
    },
  },
};
</script>

<style scoped>
</style>
