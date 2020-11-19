<template>
  <v-container>
    <v-btn
      v-if="!userIsLoggedIn"
      color="success"
      :to="{ name: 'new-service-petition', query: { id: id } }"
      >Pedir</v-btn
    >
    <v-btn
      v-if="userIsLoggedIn"
      color="primary"
      :to="{ name: 'service-edit', params: { id: service.id } }"
      >Editar
    </v-btn>
    <v-container>
      <v-row>
        <v-col cols="4">
          <UserCard
            :avatar="service.owner.avatar"
            :name="service.owner.name"
            :information="service.owner.information"
            :rating="!!service.owner.rating ? service.owner.rating : undefined"
            :id="service.owner.id"
            :role="service.owner.role"
          />
        </v-col>
        <v-col>
          <v-card>
            <v-card-title>{{ service.name }}</v-card-title>
            <v-card-subtitle v-if="service.tags">
              <v-chip v-for="(tag, index) in service.tags" :key="index">
                {{ tag }}
              </v-chip>
            </v-card-subtitle>
            <v-card-text class="pb-0">
              <p>
                <span class="font-weight-bold">Categoría: </span
                ><router-link
                  :to="{
                    name: 'services',
                    query: { category: service.category },
                  }"
                  >{{ service.category }}</router-link
                >
              </p>
            </v-card-text>
            <v-card-text>
              <p>
                <span class="font-weight-bold">Descripción: </span
                >{{ service.description }}
              </p>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </v-container>
</template>

<script>
import UserCard from "../components/UserCard";
import { mapState } from "vuex";

export default {
  props: {
    id: {
      type: [Number, String],
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
  computed: {
    userIsLoggedIn() {
      return this.loggedIn && this.service.owner.id === this.user_id;
    },
    ...mapState("session", ["user_id", "loggedIn"]),
  },
};
</script>

<style></style>
