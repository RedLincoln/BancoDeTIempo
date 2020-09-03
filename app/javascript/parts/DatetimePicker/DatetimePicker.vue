<template>
  <div class="datetime_picker">
    <div class="datetime-input"></div>
    <div class="date-picker">
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
    };
  },
  created() {
    const date = new Date(Date.now());
    this.month = date_utils.getMonth(date.getMonth());
    this.year = date.getFullYear();
  },
};
</script>

<style scoped></style>
