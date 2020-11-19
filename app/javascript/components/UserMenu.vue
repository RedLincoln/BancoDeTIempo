<template
  ><div class="text-center">
    <v-menu offset-y>
      <template v-slot:activator="{ on, attrs }">
        <span v-bind="attrs" v-on="on">
          <Avatar :avatar="avatar" :size="40" />
        </span>
      </template>
      <v-list>
        <router-link :to="{ name: 'user-profile', params: { id: user_id } }">
          <v-list-item>
            <v-list-item-icon>
              <v-icon>mdi-account</v-icon>
            </v-list-item-icon>
            <v-list-item-title>Perfil</v-list-item-title>
          </v-list-item>
        </router-link>

        <v-list-item>
          <v-btn color="error" @click="logOutHandler">
            <v-icon>mdi-logout</v-icon>
            Cerrar Sessión
          </v-btn>
        </v-list-item>
      </v-list>
    </v-menu>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("session", ["avatar", "user_id"]),
  },
  methods: {
    logOutHandler() {
      this.$store.dispatch("session/logOut");
      if (this.$route.name !== "home") this.$router.push({ name: "home" });
    },
  },
};
</script>

<style></style>
