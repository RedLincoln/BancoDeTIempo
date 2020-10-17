<template>
  <div>
    <v-tabs v-model="tab" show-arrows>
      <v-tab>Todas</v-tab>
      <v-tab>Negociación</v-tab>
      <v-tab>Aceptada</v-tab>
      <v-tab>Cancelada</v-tab>
      <v-tab>Realizada</v-tab>
      <v-tab>Valorada</v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <v-tab-item>
        <All :petitions="petitions" />
      </v-tab-item>
    </v-tabs-items>
  </div>
</template>

<script>
import All from "../components/pettions/All";

export default {
  props: {
    petitions: {
      type: Array,
      required: true,
    },
  },
  components: {
    All,
  },
  data() {
    return {
      tab: null,
    };
  },
};
</script>

<style></style>
