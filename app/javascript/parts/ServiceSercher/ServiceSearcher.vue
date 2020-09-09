<template>
  <div class="service-search position-relative mr-3" v-click-outside="hideVisualizer">
    <Searcher
      id="search-bar"
      placeholder="Buscar..."
      :search_url="$searchServicePath"
      field_name="search_string"
      search_string="search_string"
      @send-response="updateServices"
    ></Searcher>
    <ServiceVisualizer id="service-search-results" v-if="show" :inputValues="services" />
  </div>
</template>

<script>
import Searcher from "../shared/Searcher/Searcher";
import ServiceVisualizer from "./ServiceVisualizer/ServiceVisualizer";
import vClickOutside from "v-click-outside";

export default {
  directives: {
    clickOutside: vClickOutside.directive,
  },
  components: {
    Searcher,
    ServiceVisualizer,
  },
  data() {
    return {
      show: false,
      services: [],
    };
  },
  methods: {
    updateServices(response) {
      this.services = response.data.services;
      this.show = true;
    },
    hideVisualizer() {
      this.show = false;
    },
  },
};
</script>

<style scoped>
#search-bar {
  display: inline-block;
}

#service-search-results {
  z-index: 1000;
  left: 0;
}
</style>