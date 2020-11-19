<template>
  <v-app>
    <Navbar />
    <v-main>
      <ActionBar />
      <router-view :key="$route.fullPath"></router-view>
    </v-main>
    <ChatList v-if="loggedIn" />
  </v-app>
</template>

<script>
import Navbar from "./components/Navbar.vue";
import ActionBar from "./components/ActionBar";
import ChatList from "./components/ChatList";
import { mapState } from "vuex";

export default {
  components: {
    Navbar,
    ActionBar,
    ChatList,
  },
  computed: mapState("session", ["loggedIn"]),
};
</script>
