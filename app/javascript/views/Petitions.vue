<template>
  <div>
    <v-tabs v-model="tab" show-arrows>
      <v-tab>Todas</v-tab>
      <v-tab>Cliente</v-tab>
      <v-tab>Propietario</v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <v-tab-item>
        <PetitionsTable />
      </v-tab-item>
      <v-tab-item>
        <PetitionsTable :client="true" />
      </v-tab-item>
      <v-tab-item>
        <PetitionsTable :owner="true" />
      </v-tab-item>
    </v-tabs-items>
  </div>
</template>

<script>
import PetitionsTable from "../components/PetitionsTable";
import { mapState } from "vuex";

export default {
  components: {
    PetitionsTable,
  },
  data() {
    return {
      tab: null,
    };
  },
  computed: {
    ownerPetitions() {
      return this.petitions.filter((petition) => !this.isClient(petition));
    },
    clientPetitions() {
      return this.petitions.filter((petition) => this.isClient(petition));
    },
    ...mapState("session", ["user_id"]),
  },
  methods: {
    isClient(petition) {
      return this.user_id === petition.client.id;
    },
  },
};
</script>

<style></style>
