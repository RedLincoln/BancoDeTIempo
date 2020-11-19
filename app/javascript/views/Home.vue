<template>
  <div>
    <div class="flash-messages">
      <template v-for="flash in flashMessages">
        <Notice v-if="flash.type === 'notice'">{{ flash.message }}</Notice>
        <Alert v-else>{{ flash.message }}</Alert>
      </template>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  data() {
    return {
      flashMessages: [],
    };
  },
  created() {
    this.flashMessages = this.flashs;
    this.$store.dispatch("flash/removeAllFlash");
  },
  computed: {
    ...mapState("flash", ["flashs"]),
  },
};
</script>

<style>
</style>