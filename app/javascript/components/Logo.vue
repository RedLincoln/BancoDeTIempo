<template>
  <v-img :max-width="maxWidth" :src="src"> </v-img>
</template>

<script>
import logoDark from "images/logo_dark.png";
import logo from "images/logo.png";

export default {
  props: {
    maxWidth: {
      type: String,
      default: "150",
    },
    dark: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    src() {
      return this.dark ? logoDark : logo;
    },
  },
};
</script>

<style>
</style>