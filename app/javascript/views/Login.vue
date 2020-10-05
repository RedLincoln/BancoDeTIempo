<template>
  <v-row justify="center" align="center">
    <v-col cols="6">
      <v-card class="mx-auto px-4">
        <Logo maxWidth="100%" dark />
        <v-card-title>Iniciar Sesión</v-card-title>
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
          <v-text-field
            :rules="[rules.required]"
            v-model="email"
            data-testid="email-field"
            label="Email"
          >
          </v-text-field>
          <v-text-field
            v-model="password"
            data-testid="password-field"
            label="Contraseña"
            :rules="[rules.required]"
            :type="showPassword ? 'text' : 'password'"
            :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="showPassword = !showPassword"
          ></v-text-field>
          <v-card-actions>
            <v-btn color="primary" @click="logIn" data-testid="submit-btn"
              >Iniciar sesión</v-btn
            >
          </v-card-actions>
        </v-form>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",
      showPassword: false,
      errorMessage: "",
      rules: {
        required: (value) => !!value || "Campo obligatorio",
      },
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