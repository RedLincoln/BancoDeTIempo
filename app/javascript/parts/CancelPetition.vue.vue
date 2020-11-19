<template>
  <div class="cancel-petition">
    <div v-if="canceled" class="cancelled btn btn-danger">
      <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-x-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
        <path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
      </svg>
    </div>
    <form v-else :action="$cancelPetitionPath(petition_id)" method="post" @submit.prevent="cancelPetition">
      <input name="utf8" type="hidden" value="✓" />
      <input type="hidden" name="authenticity_token" :value="$getCSRFToken()" />
      <input type="submit" role="button" class="cancel btn btn-danger" value="Cancelar"/>
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
      canceled: {
        type: Boolean,
        default: false
      }
    },
    methods: {
      async cancelPetition(e) {
        try {
          await axios.post(this.$cancelPetitionPath(this.petition_id),
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
