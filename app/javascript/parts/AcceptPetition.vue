<template>
  <div class="accept-petition">
    <div v-if="accepted" class="accepted btn btn-success">
      <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-check2-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M15.354 2.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3-3a.5.5 0 1 1 .708-.708L8 9.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
        <path fill-rule="evenodd" d="M8 2.5A5.5 5.5 0 1 0 13.5 8a.5.5 0 0 1 1 0 6.5 6.5 0 1 1-3.25-5.63.5.5 0 1 1-.5.865A5.472 5.472 0 0 0 8 2.5z"/>
      </svg>
    </div>
    <form v-else :action="$acceptPetitionPath(petition_id)" method="post" @submit.prevent="acceptPetition">
      <input name="utf8" type="hidden" value="✓" />
      <input type="hidden" name="authenticity_token" :value="$getCSRFToken()" />
      <input type="submit" role="button" class="accept btn btn-success" value="Aceptar"/>
    </form>
  </div>
</template>

<script>
  import axios from 'axios'
  import formParams from "../formHelper";
  import railsFlash from "../railsFlash";

export default {
  props: {
    petition_id: {
      type: Number,
      required: true
    },
    accepted: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    async acceptPetition(e) {
      try {
        await axios.post(this.$acceptPetitionPath(this.petition_id),
          formParams.getPostParams(e.target.elements)
        )
        Turbolinks.visit(window.location)
      }catch (e) {
        if (e.status)
          railsFlash.alert((e.data.message))
      }
    }
  }
};
</script>

<style scoped>
</style>
