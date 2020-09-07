<template>
  <div class="searcher" v-click-outside="hideContent">
    <input
      type="text"
      :name="field_name"
      :placeholder="placeholder"
      v-model="fieldInput"
      @focus="showContent"
      @input="getContentOnInput"
    />
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
    dataRetriveCallback: {
      type: Function,
      required: true,
    },
  },
  data() {
    return {
      show: false,
      fieldInput: this.initialValue,
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
          this.values = this.dataRetriveCallback(response);
        });
    },
  },
};
</script>

<style scoped>
</style>
