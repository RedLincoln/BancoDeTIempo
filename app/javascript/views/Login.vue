<template>
  <div>
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
        });
    },
  },
};
</script>

<style>
</style>