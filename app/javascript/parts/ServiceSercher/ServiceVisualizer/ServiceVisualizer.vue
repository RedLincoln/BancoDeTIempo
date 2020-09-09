<template>
  <ul class="service-result-list list-group position-absolute">
    <li v-for="(service, index) in reactiveServices" :key="index" @click="visitSendPetition(service.id)" class="list-group-item">
      <span>{{ service.name }}</span>
    </li>
  </ul>
</template>

<script>
export default {
  props: { inputValues: Array },
  data() {
    return {
      reactiveServices: this.inputValues,
    };
  },
  watch: {
    inputValues(newVal, oldVal) {
      this.reactiveServices = newVal;
      console.log(this.reactiveServices);
    },
  },
  methods: {
    visitSendPetition(serviceId) {
      Turbolinks.visit(this.$sendServicePetition(serviceId));
    },
  },
};
</script>

<style scoped>
.list-group-item {
  cursor: pointer;
}
</style>