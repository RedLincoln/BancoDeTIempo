<template>
  <v-avatar :size="size">
    <img :src="avatar" alt="avatar" />
  </v-avatar>
</template>

<script>
import defaultAvatar from "images/default-avatar.jpg";

export default {
  props: {
    size: {
      type: Number,
      default: 80,
    },
    avatar: {
      type: String,
      default: defaultAvatar,
    },
  },
};
</script>

<style></style>
