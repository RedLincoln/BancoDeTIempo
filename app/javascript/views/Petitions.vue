<template>
  <div>
    <v-tabs v-model="tab" show-arrows>
      <v-tab>Todas</v-tab>
      <v-tab>Cliente</v-tab>
      <v-tab>Propietario</v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <v-tab-item>
        <PetitionsTable :inputPetitions="petitions" />
      </v-tab-item>
      <v-tab-item>
        <PetitionsTable :inputPetitions="clientPetitions" />
      </v-tab-item>
      <v-tab-item>
        <PetitionsTable :inputPetitions="ownerPetitions"></PetitionsTable>
      </v-tab-item>
    </v-tabs-items>
  </div>
</template>

<script>
import PetitionsTable from "../components/PetitionsTable";
import { mapState } from "vuex";

export default {
  props: {
    petitions: {
      type: Array,
      required: true,
    },
  },
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
