<template>
  <v-dialog v-model="dialog" width="400px">
    <template v-slot:activator="{ on, attrs }">
      <slot v-bind:attrs="attrs" v-bind:on="on"></slot>
    </template>
    <v-card>
      <v-card-title>{{ title }}</v-card-title>
      <v-card-text>
        <div class="text-center">
          <v-rating
            v-model="rating"
            color="yellow darken-3"
            background-color="grey darken-1"
            empty-icon="$ratingFull"
            half-increments
            hover
            large
          ></v-rating>
        </div>
      </v-card-text>
      <v-card-text>
        <v-textarea solo v-model="message" label="Mensaje" no-resize>
        </v-textarea>
      </v-card-text>
      <v-divider></v-divider>
      <v-card-actions class="justify-end">
        <v-btn color="primary" @click="rate" text>Valorar</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: "Valora",
    },
  },
  data() {
    return {
      dialog: false,
      rating: 4,
      message: "",
    };
  },
  methods: {
    rate() {
      this.$emit("rate", {
        rating: this.rating,
        message: this.message,
      });
      this.dialog = false;
    },
  },
};
</script>
