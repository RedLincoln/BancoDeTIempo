<template>
  <div class="datetime_picker">
    <div class="datetime-input" @click="showPicker"></div>
    <div v-if="drop" class="date-picker">
      <p>
        <span class="month">{{ month }}</span>
        <span class="year">{{ year }}</span>
      </p>
    </div>
  </div>
</template>

<script>
import date_utils from "../../date_utils";

export default {
  data: function() {
    return {
      month: "",
      year: "",
      drop: false,
    };
  },
  created() {
    const date = new Date(Date.now());
    this.month = date_utils.getMonth(date.getMonth());
    this.year = date.getFullYear();
  },
  methods: {
    showPicker: function() {
      this.drop = true;
    },
  },
};
</script>

<style scoped></style>
