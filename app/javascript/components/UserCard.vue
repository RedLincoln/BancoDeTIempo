<template>
  <router-link :to="{ name: 'user-profile', params: { id: id } }">
    <v-card :ripple="{ center: true }">
      <div class="d-flex flex-no-wrap justify-start">
        <Avatar class="mx-3" :avatar="!!avatar ? avatar : undefined" />
        <div>
          <v-card-title class="headline" v-text="name"></v-card-title>
          <v-card-subtitle v-if="role === 'admin'"
            >Administrador</v-card-subtitle
          >
          <v-card-subtitle v-else>
            Usuario
          </v-card-subtitle>
          <v-card-text class="tree-lines">{{ information }}</v-card-text>
          <v-card-actions>
            <v-icon
              v-for="filled in filledStars"
              :key="filled"
              color="yellow darken-1"
            >
              mdi-star
            </v-icon>
            <v-icon v-for="notFilled in notFilledStars" :key="notFilled">
              mdi-star-outline
            </v-icon>
            <span>{{ ratingText }}</span>
          </v-card-actions>
        </div>
      </div>
    </v-card>
  </router-link>
</template>

<script>
export default {
  props: {
    name: {
      type: String,
      required: true,
    },
    information: {
      type: String,
      default: "",
    },
    avatar: {
      type: String,
      default: "",
    },
    rating: {
      type: Number,
      default: -1,
    },
    id: {
      type: Number,
      required: true,
    },
    role: {
      type: String,
      default: "standard",
    },
  },
  data() {
    return {
      filledStars: 1,
      notFilledStars: 0,
      ratingText: "Sin Calificar",
    };
  },
  created() {
    if (this.rating >= 0 && this.rating <= 5) {
      this.filledStars = Math.floor(this.rating);
      this.notFilledStars = 5 - this.filledStars;
      this.ratingText = this.rating;
    }
  },
};
</script>

<style scoped>
.tree-lines {
  height: 3rem;
  overflow-y: hidden;
}
</style>
