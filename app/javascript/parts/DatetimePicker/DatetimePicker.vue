<template>
  <div class="datetime_picker">
    <div class="datetime-input" @click="showPicker" ref="input"></div>
    <div v-if="drop" class="date-picker">
      <div>
        <div class="previous-month" @click="loadPreviousMonth">previous</div>
        <p>
          <span class="month">{{ month }}</span>
          <span class="year">{{ year }}</span>
        </p>
        <div class="next-month" @click="loadNextMonth">next</div>
      </div>
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
      monthIndex: -1,
      year: "",
      today: { now: "", date: "" },
      daysRange: [],
      drop: false,
    };
  },
  created() {
    const date = new Date(Date.now());
    this.today.date = new Date(date.getFullYear(), date.getMonth(), 1);
    this.today.now = date;
    this.configDate(date);
  },
  methods: {
    configDate(date) {
      this.month = date_utils.getMonth(date.getMonth());
      this.monthIndex = date.getMonth();
      this.year = date.getFullYear();
      const daysOfTheMonth = date_utils.getDaysInMonth(
        this.year,
        this.monthIndex
      );
      this.daysRange = [...Array(daysOfTheMonth).keys()];
    },
    showPicker: function() {
      this.drop = true;
    },
    setDate: function(day) {
      this.$refs.input.innerHTML = `${day} ${this.month} ${this.year}`;
    },
    isBeforeToday(day) {
      return new Date(this.year, this.monthIndex, day) < this.today.now;
    },
    loadNextMonth() {
      const nextMonthDate = date_utils.getNextMonthDate(
        new Date(this.year, this.monthIndex, 1)
      );
      this.configDate(nextMonthDate);
    },
    loadPreviousMonth() {
      const previousMonthDate = date_utils.getPreviousMonthDate(
        new Date(this.year, this.monthIndex, 1)
      );
      if (previousMonthDate < this.today.date) return;
      this.configDate(previousMonthDate);
    },
  },
};
</script>

<style scoped></style>
