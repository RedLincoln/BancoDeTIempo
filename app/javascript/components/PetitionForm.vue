<template>
  <v-container fluid fill-height>
    <v-row justify="center" align="center">
      <v-col md="6" cols="12">
        <v-card class="elevation-1">
          <v-card-title>
            {{ cardTitle }}
          </v-card-title>
          <v-card-text>
            <v-form ref="form" v-model="valid" lazy-validation>
              <v-text-field
                readonly
                :value="service.name"
                label="Nombre del servicio"
              ></v-text-field>
              <v-text-field
                readonly
                :value="service.owner.name"
                label="Propietario del servicio"
              ></v-text-field>
              <v-text-field
                readonly
                :value="service.category"
                label="Categoría"
              ></v-text-field>
              <v-textarea
                readonly
                no-resize
                :value="service.description"
                label="Descripción"
              ></v-textarea>
              <v-dialog
                ref="dialog"
                v-model="modal"
                :return-valus.sync="date"
                persistent
                width="290px"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field
                    :rules="[rules.required]"
                    v-model="dateFormatted"
                    label="Día"
                    hint="formato DD/MM/YYYY"
                    persistent-hint
                    prepend-icon="mdi-calendar"
                    readonly
                    v-bind="attrs"
                    v-on="on"
                  >
                  </v-text-field>
                </template>
                <v-date-picker
                  v-model="date"
                  scrollable
                  locale="es-ES"
                  first-day-of-week="1"
                >
                  <v-spacer></v-spacer>
                  <v-btn text color="primary" @click="modal = false"
                    >Cancelar</v-btn
                  >
                  <v-btn text color="primary" @click="$refs.dialog.save(date)"
                    >OK</v-btn
                  >
                </v-date-picker>
              </v-dialog>

              <v-row>
                <v-col cols="3">
                  <v-autocomplete
                    :rules="[rules.required]"
                    v-model="hours"
                    :items="range(1, 23)"
                    label="Horas"
                  ></v-autocomplete>
                </v-col>
                <v-col cols="3">
                  <v-autocomplete
                    :rules="[rules.required]"
                    v-model="minutes"
                    :items="range(0, 59)"
                    label="Minutos"
                  ></v-autocomplete>
                </v-col>
                <v-spacer></v-spacer>
                <v-col cols="4">
                  <v-autocomplete
                    :rules="[rules.required]"
                    v-model="duration"
                    :items="range(1, 23)"
                    label="Duración"
                  ></v-autocomplete>
                </v-col>
              </v-row>

              <v-textarea
                no-resize
                outlined
                label="Información adicional"
                v-model="additionInformation"
              ></v-textarea>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-btn color="primary" @click="submit">Confirmar</v-btn>
          </v-card-actions>
        </v-card>
      </v-col></v-row
    ></v-container
  >
</template>

<script>
import ServicesService from "../services/services";
import { rules, alert } from "../utils";

const { makePetition } = ServicesService;

export default {
  props: {
    service: {
      type: Object,
      required: true,
    },
    edit: {
      type: Boolean,
      default: false,
    },
    inputPetition: {
      type: Object,
    },
  },
  data: (vm) => ({
    date: new Date().toISOString().substring(0, 10),
    dateFormatted: vm.formatDate(new Date().toISOString().substring(0, 10)),
    hours: 10,
    minutes: 0,
    duration: 2,
    modal: false,
    additionInformation: "",
    valid: true,
    rules: rules,
  }),
  created() {
    if (this.edit && this.inputPetition) {
      const date = new Date(this.inputPetition.datetime * 1000);
      const [hours, minutes, seconds] = date.toLocaleTimeString().split(/:| /);
      this.date = date.toISOString().substring(0, 10);
      this.hours = parseInt(hours);
      this.minutes = parseInt(minutes);
      this.duration = this.inputPetition.duration;
      this.additionInformation = this.inputPetition.additional_information;
    } else {
      alert("Error al intentar editar petición de servicio");
      this.$router.push({ name: "home" });
    }
  },
  watch: {
    date(val) {
      this.dateFormatted = this.formatDate(this.date);
    },
  },
  computed: {
    cardTitle() {
      return this.edit ? "Editar Petición" : "Crear Petición";
    },
  },
  methods: {
    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    submit() {
      this.$refs.form.validate();
      if (!this.valid) return;

      const [year, month, day] = this.date.split("-");
      const data = {
        datetime: new Date(
          year,
          month,
          day,
          this.hours,
          this.minutes
        ).getTime(),
        service_id: this.service.id,
        duration: this.duration,
        additional_information: this.additionInformation,
      };

      this.$emit("form-submit", data);
    },

    range(start, end) {
      return [...Array(end).keys()].map((key) => key + start);
    },
  },
};
</script>

<style></style>
