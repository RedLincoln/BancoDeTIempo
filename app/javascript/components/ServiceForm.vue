<template>
  <v-container fluid fill-height>
    <v-row justify="center" align="center">
      <v-col ms="6" cols="12">
        <v-card class="elevation-1">
          <v-card-title>{{ formTitle }}</v-card-title>
          <v-card-text>
            <slot name="error"></slot>
            <v-form ref="form" v-model="valid" lazy-validation>
              <v-text-field
                :rules="[rules.required]"
                v-model="service.name"
                label="Nombre"
              ></v-text-field>
              <v-autocomplete
                :rules="[rules.required]"
                v-model="service.category"
                :items="categories"
                item-text="name"
                label="Categoría"
              >
              </v-autocomplete>
              <v-combobox
                chips
                deletable-chips
                v-model="service.selectedTags"
                label="Etiquetas"
                multiple
                :items="tags.map((tag) => tag.name)"
              >
              </v-combobox>
              <v-textarea
                outlined
                no-resize
                v-model="service.description"
                label="Descripción"
              ></v-textarea>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-btn color="primary" @click="submit">
              Confirmar
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
import { mapState } from "vuex";

const { createService } = ServicesService;

export default {
  props: {
    offer: {
      type: Boolean,
      default: true,
    },
    edit: {
      type: Boolean,
      default: false,
    },
    inputService: {
      type: Object,
    },
  },
  data() {
    return {
      valid: true,
      service: {
        name: "",
        category: "",
        description: "",
        selectedTags: [],
      },
      rules: rules,
      errorMessage: "",
    };
  },
  computed: {
    formTitle() {
      if (this.edit) return "Editar Servicio";
      if (this.offer) return "Crear oferta";
      return "Crear demanda";
    },
    ...mapState("service", ["categories", "tags"]),
  },
  created() {
    if (this.edit && !!this.inputService) {
      this.service = { ...this.service, ...this.inputService };
      this.service.selectedTags = this.inputService.tags;
    }
  },
  methods: {
    submit() {
      this.$refs.form.validate();
      if (!this.valid) return;

      const data = {
        name: this.service.name,
        category: this.service.category,
        description: this.service.description,
        tags: this.service.selectedTags,
      };

      this.$emit("form-submit", data);
    },
  },
};
</script>

<style></style>
