<template>
  <v-container v-if="user">
    <v-row>
      <v-col cols="3">
        <v-img :src="user.avatar" max-width="100%"> </v-img>
      </v-col>
      <v-col cols="9">
        <v-card>
          <v-card-title>
            {{ user.name }}
          </v-card-title>
          <v-card-subtitle v-if="user.role === 'admin'"
            >Administrador</v-card-subtitle
          >
          <v-card-subtitle v-else>
            Usuario
          </v-card-subtitle>

          <v-card-text class="headline font-weight-bold">
            <p v-if="isVisible(user.email_visible) && !!user.email">
              Email: {{ user.email }}
            </p>
            <p v-if="isVisible(user.telephone_visible) && !!user.telephone">
              Teléfono: {{ user.telephone }}
            </p>
            <p v-if="!!user.information">Información:</p>
            <p>{{ user.information }}</p>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    <v-tabs v-model="tab">
      <v-tab>Servicios Ofertando</v-tab>
      <v-tab>Servicios Demandando</v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <v-tab-item>
        <UserServiceTable
          :services="servicesOffering"
          :userIsLoggedIn="userIsLoggedIn"
        />
      </v-tab-item>
      <v-tab-item>
        <UserServiceTable
          :services="servicesDemanding"
          :userIsLoggedIn="userIsLoggedIn"
        />
      </v-tab-item>
    </v-tabs-items>
  </v-container>
</template>

<script>
import UserServiceTable from "../components/UserServiceTable";
import UserService from "../services/user";
import defaultAvatar from "images/default-avatar.jpg";
import { mapState } from "vuex";

const { getUser } = UserService;

export default {
  components: {
    UserServiceTable,
  },
  data() {
    return {
      user: null,
      services: null,
      tab: null,
    };
  },
  beforeRouteEnter(to, from, next) {
    getUser(to.params.id).then((data) => {
      next((vm) => {
        vm.user = data.user;
        vm.services = data.services;
      });
    });
  },
  beforeRouteUpdate(to, from, next) {
    this.$store.dispatch("setLoading", true);
    getUser(to.params.id).then((data) => {
      this.user = data.user;
      this.services = data.services;
      this.$store.dispatch("setLoading", false);
      next();
    });
  },
  mounted() {
    this.$store.dispatch("setLoading", false);
  },
  computed: {
    userIsLoggedIn() {
      return this.loggedIn && this.user.id === this.user_id;
    },
    servicesDemanding() {
      return this.services.filter(
        (service) => service.service_type === "demand"
      );
    },
    servicesOffering() {
      return this.services.filter(
        (service) => service.service_type === "offer"
      );
    },
    ...mapState("session", ["loggedIn", "user_id"]),
  },
  methods: {
    isVisible(field_visible) {
      return field_visible || (this.loggedIn && this.user.id === this.user_id);
    },
  },
};
</script>

<style></style>
