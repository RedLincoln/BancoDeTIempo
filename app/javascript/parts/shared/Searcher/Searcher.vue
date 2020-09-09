<template>
  <div class="searcher">
    <input
      type="text"
      :name="field_name"
      :placeholder="placeholder"
      v-model="fieldInput"
      @focus="fetchContent(fieldInput)"
      @input="getContentOnInput"
    />
  </div>
</template>

<script>
import axios from "axios";
import vClickOutside from "v-click-outside";

const waitTime = 300;
let inputTimeout = null;

export default {
  directives: {
    clickOutside: vClickOutside.directive,
  },
  props: {
    initialValue: String,
    placeholder: String,
    search_url: {
      type: String,
      required: true,
    },
    field_name: {
      type: String,
      required: true,
    },
    search_string: {
      type: String,
      default: "search_string",
    },
  },
  data() {
    return {
      fieldInput: this.initialValue,
    };
  },
  watch: {
    initialValue(newVal, oldVal) {
      this.fieldInput = newVal;
    },
  },
  methods: {
    setFieldValue(value) {
      this.fieldInput = value;
    },
    getContentOnInput() {
      clearTimeout(inputTimeout);
      inputTimeout = setTimeout(() => {
        this.fetchContent(this.fieldInput);
      }, waitTime);
    },
    fetchContent(search_string) {
      axios
        .get(this.search_url, {
          params: {
            [`${this.search_string}`]: search_string,
          },
        })
        .then((response) => {
          this.$emit("send-response", response);
        });
    },
  },
};
</script>

<style scoped>
</style>
