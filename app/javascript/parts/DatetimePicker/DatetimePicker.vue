<template>
  <div class="datetime_picker">
    <div class="form-control position-relative" @click="togglePicker">
      <div class="position-absolute text-primary small top-0">
        Selecciona fecha y hora
      </div>
      <div class="datetime-input position-absolute bottom-0" ref="input"></div>
    </div>
    <div v-if="drop" class="date-picker">
      <div
        class="d-flex justify-content-between bg-primary align-items-center mt-1 p-2"
      >
        <div class="previous-month" @click="loadPreviousMonth">Anterior</div>
        <p class="mb-0">
          <span class="month">{{ month }}</span>
          <span class="year">{{ year }}</span>
        </p>
        <div class="next-month" @click="loadNextMonth">Siguiente</div>
      </div>
      <table class="table">
        <thead>
          <tr>
            <th scope="col">Lun</th>
            <th scope="col">Mar</th>
            <th scope="col">Mie</th>
            <th scope="col">Jue</th>
            <th scope="col">Vie</th>
            <th scope="col">Sab</th>
            <th scope="col">Dom</th>
          </tr>
        </thead>
        <tbody>
          <template v-for="week in daysRange">
            <tr>
              <template v-for="day in week">
                <td v-if="isOffsetDay(day)">{{ day }}</td>
                <td v-else-if="isBeforeToday(day)" class="day text-muted">
                  {{ day }}
                </td>
                <td v-else class="day hover-primary" @click="setDate(day)">
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
      this.createDaysRange(daysOfTheMonth);
    },
    createDaysRange: function(totalDays) {
      this.daysRange = [];
      let offset = date_utils.getOffsetWeekDayOfMonth(
        new Date(this.year, this.monthIndex, 1)
      );
      let day = 0;
      let week = [];
      while (offset--) week.push("");
      while (day < totalDays) {
        if (week.length % 7 === 0) {
          this.daysRange.push(week);
          week = [];
        }
        day++;
        week.push(day);
      }
      if (week.length > 0) {
        this.daysRange.push(week);
      }
    },
    togglePicker: function() {
      this.drop = !this.drop;
    },
    setDate: function(day) {
      this.$refs.input.innerHTML = `${day} ${this.month} ${this.year}`;
    },
    isBeforeToday(day) {
      return new Date(this.year, this.monthIndex, day) < this.today.now;
    },
    isOffsetDay(day) {
      return day === "";
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

<style scoped>
.date-picker {
  z-index: 10;
}
</style>
