<template>
  <ServiceForm @form-submit="submit" :offer="offer">
    <tempalte v-slot:error>
      <Alert v-show="errorMessage.length > 0">
        {{ errorMessage }}
      </Alert>
    </tempalte>
  </ServiceForm>
</template>

<script>
import ServiceForm from "../components/ServiceForm";
import ServicesService from "../services/services";

const { createService } = ServicesService;

export default {
  props: {
    offer: {
      type: Boolean,
      default: true,
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
    submit(formData) {
      createService(formData)
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
