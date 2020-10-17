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

    <ServicesCard
      v-if="$vuetify.breakpoint.name === 'xs'"
      :services="services.services"
    />

    <ServicesTable v-else :services="services.services" />
  </div>
</template>

<script>
import ServiceService from "../services/services";
import { mapState } from "vuex";
import ServicesCard from "../components/ServicesCard";
import ServicesTable from "../components/ServicesTable";

const { getAll } = ServiceService;

export default {
  props: {
    services: {
      type: Object,
      required: true,
    },
  },
  components: {
    ServicesCard,
    ServicesTable,
  },
  data() {
    return {};
  },
  computed: mapState("session", ["loggedIn"]),
};
</script>

<style></style>
