<template>
  <div class="searcher">
    <input
      type="text"
      :name="field_name"
      :placeholder="placeholder"
      v-model="fieldInput"
      @focus="showContent"
      @input="getContentOnInput"
    />
    <span
      v-if="show"
      class="close_filter one-letter-square border rounded-circle bg-secondary text-light"
      @click="hideContent"
    >x</span>
    <ul v-if="show" class="content_list list-group">
      <li
        class="list-group-item list-group-item-action"
        v-for="(value, index) in values"
        :key="index"
        @click="setFieldValue(value)"
      >{{ value }}</li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";

const waitTime = 300;
let inputTimeout = null;

export default {
  props: {
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
      show: false,
      fieldInput: "",
      values: [],
    };
  },
  watch: {
    show() {
      if (this.show) this.fetchContent("");
    },
  },
  methods: {
    setFieldValue(value) {
      this.fieldInput = value;
    },
    showContent() {
      this.show = true;
    },
    hideContent() {
      this.show = false;
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
          this.values = response.data.map((category) => category.name);
        });
    },
  },
};
</script>

<style scoped>
</style>
