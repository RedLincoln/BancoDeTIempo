<template>
  <div class="datetime_picker">
    <input
      type="hidden"
      v-model="computedDateTime"
      name="transaction[datetime]"
      class="transaction-datetime"
    />
    <div class="form-group">
      <label for="transaction-datetime"> Elige fecha y hora: </label>
      <div
        class="form-control position-relative"
        @click="togglePicker"
        id="transaction-datetime"
      >
        <div class="position-absolute text-primary small top-0">
          Selecciona fecha y hora
        </div>
        <div class="datetime-input position-absolute bottom-0" ref="input">
          {{ computeDate }} {{ computeTime }}
        </div>
      </div>
    </div>
    <div v-if="drop" class="date-picker d-flex">
      <div class="w-75">
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
            <template v-for="(week, weekIndex) in daysRange">
              <tr :key="weekIndex">
                <template v-for="(day, index) in week">
                  <td :key="index" v-if="isOffsetDay(day)">{{ day }}</td>
                  <td
                    :key="index"
                    v-else-if="isBeforeToday(day)"
                    class="day text-muted"
                  >
                    {{ day }}
                  </td>
                  <td
                    :key="index"
                    v-else
                    class="day hover-primary"
                    @click="setDate(day)"
                    :class="{ active: activeDay === day }"
                  >
                    {{ day }}
                  </td>
                </template>
              </tr>
            </template>
          </tbody>
        </table>
      </div>
      <div class="time-picker w-25 ml-3">
        <div
          class="d-flex justify-content-between bg-primary align-items-center mt-1 p-2"
        >
          <span>Horas</span>
          <span>Minutos</span>
        </div>
        <div class="row">
          <ul class="hour-picker col">
            <li
              v-for="(hour, index) in hourRange"
              :key="index"
              class="time"
              @click="selectHour(hour)"
              :class="{ active: activeHour === hour }"
            >
              <span>{{ hour }}</span>
            </li>
          </ul>
          <ul class="minutes-picker col">
            <li
              v-for="(minutes, index) in minutesRange"
              :key="index"
              class="time"
              @click="selectMinutes(minutes)"
              :class="{ active: activeMinutes === minutes }"
            >
              {{ minutes }}
            </li>
          </ul>
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
      hourRange: [...Array(24).keys()],
      minutesRange: [...Array(60).keys()],
      activeMinutes: undefined,
      activeHour: undefined,
      month: "",
      monthIndex: -1,
      year: "",
      activeDay: undefined,
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
  computed: {
    computeTime() {
      const minutes = this.getMinutes();
      const hours = this.getHours();
      return `${hours}${minutes}`;
    },
    computeDate() {
      let result = "";
      if (this.activeDay !== undefined) {
        result = `${this.activeDay} ${this.month} ${this.year}`;
      }
      return result;
    },
    computedDateTime() {
      let datetime = "";
      const minutes = this.getMinutes();
      const hours = this.getHours();
      const time = ` ${hours}${minutes}`;
      if (this.activeDay !== undefined) {
        datetime = `${this.activeDay}/${this.monthIndex + 1}/${this.year}`;
      }
      return `${datetime}${time}`;
    },
  },
  methods: {
    emitSelectedTime() {
      const hours = this.activeHour === undefined ? 0 : this.activeHour;
      const minutes = this.activeMinutes === undefined ? 0 : this.activeMinutes;
      this.$emit("selected-time", hours * 60 * 60 + minutes * 60);
    },
    getMinutes() {
      if (this.activeMinutes === undefined && this.activeHour === undefined)
        return "";
      if (this.activeMinutes === undefined) return "00";
      return this.activeMinutes < 10
        ? `0${this.activeMinutes}`
        : this.activeMinutes;
    },
    getHours() {
      if (this.activeMinutes === undefined && this.activeHour === undefined)
        return "";
      return this.activeHour === undefined ? "0:" : `${this.activeHour}:`;
    },
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
    selectHour(hour) {
      this.activeHour = hour;
      this.emitSelectedTime();
    },
    selectMinutes(minutes) {
      this.activeMinutes = minutes;
      this.emitSelectedTime();
    },
    setDate: function(day) {
      this.activeDay = day;
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

.time-picker {
  overflow: hidden;
}

.time-picker ul {
  list-style: none;
  padding-left: 0;
  overflow-y: scroll;
  height: 400px;
}

.time-picker ul li:hover {
  cursor: pointer;
  background-color: #007bff;
}

.active {
  background-color: #007bff;
}

.datetime-input:hover {
  cursor: pointer;
}

.hour-picker,
.minutes-picker {
  text-align: center;
}
</style>
