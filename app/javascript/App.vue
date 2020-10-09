<template>
  <v-app>
    <Navbar />
    <v-main>
      <ActionBar />
      <v-container fluid fill-height>
        <router-view></router-view>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import Navbar from "./components/Navbar.vue";
import ActionBar from "./components/ActionBar";

export default {
  components: {
    Navbar,
    ActionBar,
  },
};
</script>