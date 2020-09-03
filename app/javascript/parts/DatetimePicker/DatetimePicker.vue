<template>
  <div class="datetime_picker">
    <div class="datetime-input" @click="showPicker" ref="input"></div>
    <div v-if="drop" class="date-picker">
      <p>
        <span class="month">{{ month }}</span>
        <span class="year">{{ year }}</span>
      </p>
      <div>
        <div v-for="day in daysRange">
          <div v-if="isBeforeToday(day)" class="day">
            {{ day }}
          </div>
          <div v-else class="day" @click="setDate(day)">
            {{ day }}
          </div>
        </div>
      </div>
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
      today: { day: "" },
      daysRange: [],
      drop: false,
    };
  },
  created() {
    const date = new Date(Date.now());
    this.today.day = date.getDate();
    this.month = date_utils.getMonth(date.getMonth());
    this.year = date.getFullYear();
    const daysOfTheMonth = date_utils.getDaysInMonth(
      this.year,
      date.getMonth()
    );
    this.daysRange = [...Array(daysOfTheMonth).keys()];
  },
  methods: {
    showPicker: function() {
      this.drop = true;
    },
    setDate: function(day) {
      this.$refs.input.innerHTML = `${day} ${this.month} ${this.year}`;
    },
    isBeforeToday(day) {
      return day < this.today.day;
    },
  },
};
</script>

<style scoped></style>
