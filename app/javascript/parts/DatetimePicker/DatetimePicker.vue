<template>
  <div class="datetime_picker">
    <div  class="form-control position-relative" @click="showPicker">
      <div class="position-absolute text-primary small top-0">Selecciona fecha y hora</div>
      <div class="datetime-input position-absolute bottom-0" ref="input"></div>
    </div>
    <div v-if="drop" class="date-picker">
      <div>
        <div class="previous-month" @click="loadPreviousMonth">previous</div>
        <p>
          <span class="month">{{ month }}</span>
          <span class="year">{{ year }}</span>
        </p>
        <div class="next-month" @click="loadNextMonth">next</div>
      </div>
      <table class="table">
        <thead>
          <tr>
            <th scope="col">Lunes</th>
            <th scope="col">Martes</th>
            <th scope="col">Miercoles</th>
            <th scope="col">Jueves</th>
            <th scope="col">Viernes</th>
            <th scope="col">Sabado</th>
            <th scope="col">Domingo</th>
          </tr>
        </thead>
        <tbody>
          <template v-for="week in daysRange">
            <tr>
              <template v-for="day in week">
                <td v-if="isBeforeToday(day)" class="day">
                  {{ day }}
                </td>
                <td v-else class="day" @click="setDate(day)">
                  {{ day }}
                </td>
              </template>
            </tr>
          </template>
        </tbody>
      </table>
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
      this.createDaysRange(daysOfTheMonth)
    },
    createDaysRange: function(totalDays){
      this.daysRange = [];
      let day = 0;
      let week = [];
      while(day < totalDays){
        if (day % 7 === 0){
          this.daysRange.push(week);
          week = [];
        }
        day++;
        week.push(day);

      }
      if (week.length > 0){
        this.daysRange.push(week);
      }
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
