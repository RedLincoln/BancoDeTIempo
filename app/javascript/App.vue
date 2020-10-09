<template>
  <v-app>
    <Navbar />
    <v-main>
      <ActionBar />
      <router-view></router-view>
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
