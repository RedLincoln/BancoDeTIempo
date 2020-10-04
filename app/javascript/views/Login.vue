<template>
  <div>
    <v-alert
      data-testid="error-message"
      v-show="errorMessage.length > 0"
      border="right"
      colored-border
      type="error"
      elevation="2"
    >
      {{ errorMessage }}
    </v-alert>
    <v-form data-testid="login-form">
      <v-text-field v-model="email" data-testid="email-field"> </v-text-field>
      <v-text-field
        v-model="password"
        data-testid="password-field"
      ></v-text-field>
      <v-btn @click="logIn" data-testid="submit-btn"></v-btn>
    </v-form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",
      errorMessage: "",
    };
  },
  methods: {
    logIn() {
      this.$store
        .dispatch("session/logIn", {
          email: this.email,
          password: this.password,
        })
        .then((number) => {
          this.$router.push({ name: "home" });
        })
        .catch(({ message }) => {
          this.errorMessage = message;
        });
    },
  },
};
</script>

<style>
</style>