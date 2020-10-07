<template>
  <div>
    <v-form>
      <v-text-field v-model="name" data-testid="name-field"> </v-text-field>
      <v-text-field v-model="email" data-testid="email-field"></v-text-field>
      <v-file-input data-testid="avatar-field"></v-file-input>
      <v-textarea v-model="information" data-testid="information-field">
      </v-textarea>
      <v-btn @click="submit" data-testid="submit-button">Registrarse</v-btn>
    </v-form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      name: "",
      information: "",
      avatar: "",
    };
  },
  methods: {
    processAvatar(event) {
      this.avatar = event.target.files[0];
    },
    submit() {
      this.$store.dispatch("session/signUp", {
        email: this.email,
        name: this.name,
        information: this.information,
        avatar: this.avatar,
      });
    },
  },
};
</script>

<style>
</style>