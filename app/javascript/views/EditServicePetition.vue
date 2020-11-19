<template>
  <PetitionForm
    :service="service"
    edit
    :inputPetition="petition"
    @form-submit="submit"
  />
</template>

<script>
import PetitionService from "../services/petitions";
import PetitionForm from "../components/PetitionForm";
import { rules, notice } from "../utils";

const { updatePetition } = PetitionService;

export default {
  components: {
    PetitionForm,
  },
  props: {
    service: {
      type: Object,
      required: true,
    },
    petition: {
      type: Object,
      require: true,
    },
  },

  methods: {
    submit(params) {
      updatePetition({ id: this.petition.id, params }).then((response) => {
        notice("Petición actualizada satisfactoriamente");
        this.$router.push({ name: "home" });
      });
    },
  },
};
</script>

<style></style>
