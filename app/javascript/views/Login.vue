<template>
  <v-row justify="center" align="center">
    <v-col cols="12" md="6">
      <v-card class="mx-auto px-4">
        <Logo maxWidth="100%" dark />
        <v-card-title>Iniciar Sesión</v-card-title>
        <Alert v-show="errorMessage.length > 0">
          {{ errorMessage }}
        </Alert>
        <v-form
          data-testid="login-form"
          ref="form"
          v-model="valid"
          lazy-validation
        >
          <v-text-field
            :rules="[rules.required, rules.email]"
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
import { rules } from "../utils";

export default {
  data() {
    return {
      valid: true,
      email: "",
      password: "",
      showPassword: false,
      errorMessage: "",
      rules: rules,
    };
  },
  methods: {
    logIn() {
      this.$refs.form.validate();
      if (!this.valid) return;

      this.$store
        .dispatch("session/logIn", {
          email: this.email,
          password: this.password,
        })
        .then((user_name) => {
          this.$store.dispatch("flash/addFlash", {
            type: "notice",
            message: `Bienvenido ${user_name}`,
          });

          this.$router.push({ name: "home" });
        })
        .catch(({ message }) => {
          this.errorMessage = message;
        });
    },
  },
};
</script>

<style></style>
