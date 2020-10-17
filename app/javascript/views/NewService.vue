<template>
  <v-container fluid fill-height>
    <v-row justify="center" align="center">
      <v-col ms="6" cols="12">
        <v-card class="elevation-1">
          <v-card-title v-if="offer">
            Crear Servicio
          </v-card-title>
          <v-card-title v-else>
            Crear Demanda
          </v-card-title>
          <v-card-text>
            <Alert v-show="errorMessage.length > 0">
              {{ errorMessage }}
            </Alert>
            <v-form ref="form" v-model="valid" lazy-validation>
              <v-text-field
                :rules="[rules.required]"
                v-model="name"
                label="Nombre"
              ></v-text-field>
              <v-autocomplete
                :rules="[rules.required]"
                v-model="category"
                :items="categories"
                item-text="name"
                label="Categoría"
              >
              </v-autocomplete>
              <v-combobox
                chips
                deletable-chips
                v-model="selectedTags"
                label="Etiquetas"
                multiple
                :items="tags"
              >
              </v-combobox>
              <v-textarea
                outlined
                no-resize
                v-model="description"
                label="Descripción"
              ></v-textarea>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-btn color="primary" @click="submit">
              <span v-if="offer">
                Crear Servicio
              </span>
              <span v-else>
                Crear Demanda
              </span>
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { rules } from "../utils";
import ServicesService from "../services/services";

const { createService } = ServicesService;

export default {
  props: {
    categories: {
      type: Array,
      required: true,
    },
    tags: {
      type: Array,
      required: true,
    },
    offer: {
      type: Boolean,
      default: true,
    },
  },
  data() {
    return {
      valid: true,
      name: "",
      category: "",
      description: "",
      selectedTags: [],
      rules: rules,
      errorMessage: "",
    };
  },
  methods: {
    submit() {
      this.$refs.form.validate();
      if (!this.valid) return;

      const data = {
        name: this.name,
        category: this.category,
        description: this.description,
        tags: this.selectedTags,
      };

      createService(data)
        .then((message) => {
          this.$store.dispatch("flash/addFlash", {
            type: "notice",
            message,
          });
          this.$router.push({ name: "home" });
        })
        .catch((err) => {
          this.errorMessage = err.response.data.message;
        });
    },
  },
};
</script>

<style></style>
