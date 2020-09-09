<template>
  <ul class="content_list list-group">
    <li
      class="list-group-item list-group-item-action"
      v-for="(value, index) in values"
      :key="index"
      @click="setFieldValue(value)"
    >{{ value }}</li>
  </ul>
</template>

<script>
export default {
  props: {
    inputValues: Array,
  },
  data() {
    return {
      values: this.inputValues,
    };
  },
  watch: {
    inputValues(newVal, oldVal) {
      this.values = newVal;
    },
  },
  methods: {
    setFieldValue(value) {
      this.$emit("set-field-value", value);
    },
  },
};
</script>