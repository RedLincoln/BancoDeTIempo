<template>
  <ServiceForm
    v-if="!!service"
    edit
    :inputService="service"
    @form-submit="submit"
  >
    <tempalte v-slot:error>
      <Alert v-show="errorMessage.length > 0">
        {{ errorMessage }}
      </Alert>
    </tempalte>
  </ServiceForm>
</template>

<script>
import ServiceForm from "../components/ServiceForm";
import ServiceService from "../services/services";
import { notice } from "../utils";

const { updateService } = ServiceService;

export default {
  props: {
    service: {
      type: Object,
      required: true,
    },
  },
  components: {
    ServiceForm,
  },
  data() {
    return {
      errorMessage: "",
    };
  },
  methods: {
    submit(params) {
      updateService({ id: this.service.id, params })
        .then(() => {
          notice("Servicio editado satisfactoriamente");
          this.$router.push({ name: "home" });
        })
        .catch((err) => {
          if (err.status) {
            this.errorMessage = err.response.data.errors;
          }
        });
    },
  },
};
</script>

<style></style>
