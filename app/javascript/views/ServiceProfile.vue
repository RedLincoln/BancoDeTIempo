<template>
  <v-container>
    <v-btn
      color="success"
      :to="{ name: 'new-service-petition', query: { id: id } }"
      >Pedir</v-btn
    >
    <UserCard
      :avatar="user.avatar"
      :name="user.name"
      :information="user.information"
      :rating="!!user.rating ? user.rating : undefined"
      :id="user.id"
      :role="user.role"
    />
  </v-container>
</template>

<script>
import UserCard from "../components/UserCard";

export default {
  props: {
    id: {
      type: [Number, String],
      required: true,
    },
    user: {
      type: Object,
      required: true,
    },
    service: {
      type: Object,
      required: true,
    },
  },
  components: {
    UserCard,
  },
};
</script>

<style></style>
