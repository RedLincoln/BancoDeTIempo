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

const { getService } = ServiceService;

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
    submit(formData) {},
  },
};
</script>

<style></style>
