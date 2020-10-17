<template>
  <div>
    <v-card v-for="(service, index) in services" :key="index" class="mb-3">
      <v-card-title>{{ service.name }}</v-card-title>
      <v-card-text>
        <v-subheader class="font-weight-bold">Categoría</v-subheader>
        <p>{{ service.category }}</p>
      </v-card-text>
      <v-card-text>
        <v-subheader class="font-weight-bold">Descripción</v-subheader>
        <p>{{ service.description }}</p>
      </v-card-text>
      <v-card-text>
        <v-subheader><v-icon>mdi-account</v-icon>Propietario</v-subheader>
        <UserCard
          :name="service.owner.name"
          :information="service.owner.information"
          :avatar="service.owner.avatar"
          :id="service.owner.id"
          :role="service.owner.role"
        />
      </v-card-text>
      <v-card-actions>
        <v-btn
          color="success"
          :to="{ name: 'new-service-petition', query: { id: service.id } }"
          >Pedir</v-btn
        >
      </v-card-actions>
    </v-card>
  </div>
</template>

<script>
import UserCard from "./UserCard";

export default {
  props: {
    services: {
      type: Array,
      required: true,
    },
  },
  components: {
    UserCard,
  },
};
</script>

<style></style>
