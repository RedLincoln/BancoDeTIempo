<template>
  <PetitionForm :service="service" @form-submit="submit" />
</template>

<script>
import ServicesService from "../services/services";
import PetitionForm from "../components/PetitionForm";
import { rules } from "../utils";

const { makePetition } = ServicesService;

export default {
  components: {
    PetitionForm,
  },
  props: {
    service: {
      type: Object,
      required: true,
    },
  },

  methods: {
    submit(data) {
      makePetition(data)
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
