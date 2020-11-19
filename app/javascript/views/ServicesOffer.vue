<template>
  <div class="mt-4">
    <v-btn
      v-if="loggedIn"
      class="ml-3 mb-3"
      color="primary"
      :to="{ name: 'new-service', params: { offer: true } }"
    >
      <v-icon left dark> mdi-plus</v-icon>
      Crear Servicio</v-btn
    >

    <ServicesTable />
  </div>
</template>

<script>
import { mapState } from "vuex";
import ServicesTable from "../components/ServicesTable";

export default {
  components: {
    ServicesTable,
  },
  computed: {
    ...mapState("session", ["loggedIn"]),
  },
};
</script>

<style></style>
