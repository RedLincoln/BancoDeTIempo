<template>
  <Center>
    <template v-slot:title>
      <v-card-title>Registrarse</v-card-title>
    </template>
    <template v-slot:form>
      <Alert v-show="errorMessage.length > 0">
        {{ errorMessage }}
      </Alert>
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-text-field
          :rules="[rules.required]"
          label="Nombre*"
          v-model="name"
          data-testid="name-field"
        >
        </v-text-field>
        <v-text-field
          :rules="[rules.required, rules.email]"
          label="Email*"
          placeholder="nombre@example.com"
          v-model="email"
          data-testid="email-field"
        ></v-text-field>
        <v-row>
          <v-col class="d-flex justify-center" cols="3">
            <v-avatar size="60">
              <img :src="imageUrl" alt="avatar" />
            </v-avatar>
          </v-col>
          <v-col cols="7">
            <v-file-input
              label="Avatar"
              placeholder="adjunta tu avatar"
              accept="image/jpeg, image/png"
              prepend-icon="mdi-camera"
              data-testid="avatar-field"
              v-model="avatar"
              @change="processAvatar"
            ></v-file-input>
          </v-col>
        </v-row>
        <v-textarea
          label="Información adicional"
          placeholder="Añade información sobre ti "
          v-model="information"
          data-testid="information-field"
          outlined
          no-resize
        >
        </v-textarea>
        <v-card-actions>
          <v-tooltip bottom>
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                color="primary"
                v-bind="attrs"
                v-on="on"
                @click="submit"
                data-testid="submit-button"
                :disabled="!valid"
                >Registrarse</v-btn
              >
            </template>
            <span>Los campos con * son obligatorios</span>
          </v-tooltip>
        </v-card-actions>
      </v-form>
    </template>
  </Center>
</template>

<script>
import Center from "../components/Center";
import { rules } from "../utils";
import defaultAvatar from "images/default-avatar.jpg";

export default {
  components: {
    Center,
  },
  data() {
    return {
      valid: true,
      rules: rules,
      email: "",
      name: "",
      information: "",
      avatar: null,
      errorMessage: "",
      imageUrl: defaultAvatar,
    };
  },
  methods: {
    processAvatar(event) {
      this.imageUrl = URL.createObjectURL(this.avatar);
    },
    submit() {
      this.$refs.form.validate();
      if (!this.valid) return;
      this.$store
        .dispatch("session/signUp", {
          email: this.email,
          name: this.name,
          information: this.information,
          avatar: this.avatar,
        })
        .then(() => {
          this.$store.dispatch("flash/addFlash", {
            type: "notice",
            message:
              "Usuario creado satisfactoriamente. Se le ha enviado un correo con indicaciones.",
          });
          this.$router.push({ name: "home" });
        })
        .catch((error) => {
          console.log(error);
          this.errorMessage = error.response.data.message;
        });
    },
  },
};
</script>

<style>
</style>