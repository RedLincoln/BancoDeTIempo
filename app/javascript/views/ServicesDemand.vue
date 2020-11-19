<template>
  <div class="mt-4">
    <v-btn
      v-if="loggedIn"
      class="ml-3 mb-3"
      color="primary"
      :to="{ name: 'new-demand' }"
    >
      <v-icon left dark> mdi-plus</v-icon>
      Crear Demanda</v-btn
    >

    <ServicesTable :services="services" />
  </div>
</template>

<script>
import { mapState } from "vuex";
import ServicesTable from "../components/ServicesTable";

export default {
  props: {
    services: {
      type: Array,
      required: true,
    },
  },
  components: {
    ServicesTable,
  },
  computed: {
    ...mapState("session", ["loggedIn"]),
  },
};
</script>

<style></style>
