import { shallowMount } from "@vue/test-utils";
import DatetimePicker from "../../app/javascript/parts/DatetimePicker/DatetimePicker";

// Spanish testing

describe("DatetimePicker.vue", () => {
  describe("dropdown", () => {
    it("initial state hides picker", () => {
      const wrapper = shallowMount(DatetimePicker);
      expect(wrapper.find(".date-picker").exists()).toBeFalsy();
    });

    it("click on datetime-input show picker", async () => {
      const wrapper = shallowMount(DatetimePicker);
      await wrapper.find(".datetime-input").trigger("click");
      expect(wrapper.find(".date-picker").exists()).toBeTruthy();
    });

    it("click on datetime-input hides picker", async () => {
      const wrapper = shallowMount(DatetimePicker);
      await wrapper.find(".datetime-input").trigger("click");
      await wrapper.find(".datetime-input").trigger("click");
      expect(wrapper.find(".date-picker").exists()).toBeFalsy();
    });
  });

  describe("date-picker content", () => {
    const RealDate = Date.now;

    afterEach(() => {
      global.Date.now = RealDate;
    });

    it("initial state have no datetime selected", () => {
      const wrapper = shallowMount(DatetimePicker);
      expect(wrapper.find(".datetime-input").text()).toBe("");
    });

    it("initial date selection is present Date", async () => {
      global.Date.now = jest.fn(() => {
        return new Date("August 19, 1975 23:15:30").valueOf();
      });

      const wrapper = shallowMount(DatetimePicker);

      const date = new Date(Date.now());

      await wrapper.find(".datetime-input").trigger("click");

      const datePicker = wrapper.find(".date-picker");

      expect(datePicker.find(".month").text()).toBe("Agosto");
      expect(datePicker.find(".year").text()).toBe(
        date.getFullYear().toString()
      );
    });

    it("date-picker container the days of the month", async () => {
      global.Date.now = jest.fn(() => {
        return new Date("February 19, 1975 23:15:30").valueOf();
      });

      const wrapper = shallowMount(DatetimePicker);
      const date = new Date(Date.now());

      const daysInMonth = new Date(
        date.getFullYear(),
        date.getMonth() + 1,
        0
      ).getDate();

      const daysRange = [...Array(daysInMonth).keys()].map((number) =>
        (number + 1).toString()
      );

      await wrapper.find(".datetime-input").trigger("click");

      const datePicker = wrapper.find(".date-picker");
      const days = datePicker.findAll(".day");

      const recived = days.wrappers.filter((el) =>
        daysRange.includes(el.text())
      ).length;

      expect(recived).toBe(daysInMonth);
    });

    it("click on day sets date", async () => {
      global.Date.now = jest.fn(() => {
        return new Date("February 1, 1975 23:15:30").valueOf();
      });
      const day = 7;
      const wrapper = shallowMount(DatetimePicker);

      await wrapper.find(".datetime-input").trigger("click");

      const datePicker = wrapper.find(".date-picker");

      await datePicker
        .findAll(".day")
        .at(day - 1)
        .trigger("click");

      expect(wrapper.find(".datetime-input").text()).toBe(
        `${day} Febrero 1975`
      );
    });

    it("click on days before Date.now does not set date", async () => {
      global.Date.now = jest.fn(() => {
        return new Date("February 15, 1975 23:15:30").valueOf();
      });
      const day = 7;
      const wrapper = shallowMount(DatetimePicker);

      await wrapper.find(".datetime-input").trigger("click");

      const datePicker = wrapper.find(".date-picker");

      await datePicker
        .findAll(".day")
        .at(day - 1)
        .trigger("click");

      expect(wrapper.find(".datetime-input").text()).toBe("");
    });

    it("can go to the next month", async () => {
      global.Date.now = jest.fn(() => {
        return new Date("December 15, 1975 23:15:30").valueOf();
      });

      const wrapper = shallowMount(DatetimePicker);

      await wrapper.find(".datetime-input").trigger("click");
      const datePicker = wrapper.find(".date-picker");
      await datePicker.find(".next-month").trigger("click");

      expect(datePicker.find(".month").text()).toBe("Enero");
      expect(datePicker.find(".year").text()).toBe("1976");
    });

    it("cant go to the previous month of Date.now()", async () => {
      global.Date.now = jest.fn(() => {
        return new Date("December 15, 1975 23:15:30").valueOf();
      });

      const wrapper = shallowMount(DatetimePicker);

      await wrapper.find(".datetime-input").trigger("click");
      const datePicker = wrapper.find(".date-picker");
      await datePicker.find(".previous-month").trigger("click");

      expect(datePicker.find(".month").text()).toBe("Diciembre");
      expect(datePicker.find(".year").text()).toBe("1975");
    });

    it("can go to the previous month", async () => {
      global.Date.now = jest.fn(() => {
        return new Date("December 15, 1975 23:15:30").valueOf();
      });

      const wrapper = shallowMount(DatetimePicker);

      await wrapper.find(".datetime-input").trigger("click");
      const datePicker = wrapper.find(".date-picker");
      await datePicker.find(".next-month").trigger("click");
      await datePicker.find(".previous-month").trigger("click");

      expect(datePicker.find(".month").text()).toBe("Diciembre");
      expect(datePicker.find(".year").text()).toBe("1975");
    });

    it("click on days in next month sets date", async () => {
      global.Date.now = jest.fn(() => {
        return new Date("February 15, 1975 23:15:30").valueOf();
      });
      const day = 7;
      const wrapper = shallowMount(DatetimePicker);

      await wrapper.find(".datetime-input").trigger("click");
      const datePicker = wrapper.find(".date-picker");
      await datePicker.find(".next-month").trigger("click");

      await datePicker
        .findAll(".day")
        .at(day - 1)
        .trigger("click");

      expect(wrapper.find(".datetime-input").text()).toBe(`${day} Marzo 1975`);
    });
  });

  describe("time-picker content", () => {
    it("can select the hour", async () => {
      const wrapper = shallowMount(DatetimePicker);
      const hour = 8;

      await wrapper.find(".datetime-input").trigger("click");

      const timePicker = wrapper.find(".time-picker");

      await timePicker
        .find(".hour-picker")
        .findAll(".time")
        .at(hour)
        .trigger("click");

      expect(wrapper.find(".datetime-input").text()).toBe("8:00");
    });

    it("can select the minutes", async () => {
      const wrapper = shallowMount(DatetimePicker);
      const minutes = 6;

      await wrapper.find(".datetime-input").trigger("click");

      const timePicker = wrapper.find(".time-picker");

      await timePicker
        .find(".minutes-picker")
        .findAll(".time")
        .at(minutes)
        .trigger("click");

      expect(wrapper.find(".datetime-input").text()).toBe("0:06");
    });

    it("can select minutes and hour at the same time", async () => {
      const wrapper = shallowMount(DatetimePicker);
      const minutes = 26;
      const hour = 11;

      await wrapper.find(".datetime-input").trigger("click");

      const timePicker = wrapper.find(".time-picker");

      await timePicker
        .find(".minutes-picker")
        .findAll(".time")
        .at(minutes)
        .trigger("click");

      await timePicker
        .find(".hour-picker")
        .findAll(".time")
        .at(hour)
        .trigger("click");

      expect(wrapper.find(".datetime-input").text()).toBe("11:26");
    });
  });

  describe("time-picker and date-picker", () => {
    const RealDate = Date.now;

    afterEach(() => {
      global.Date.now = RealDate;
    });

    it("can select time and date at the same time", async () => {
      global.Date.now = jest.fn(() => {
        return new Date("February 1, 1975 23:15:30").valueOf();
      });

      const wrapper = shallowMount(DatetimePicker);
      const minutes = 26;
      const hour = 11;
      const day = 8;

      await wrapper.find(".datetime-input").trigger("click");

      const timePicker = wrapper.find(".time-picker");

      await timePicker
        .find(".minutes-picker")
        .findAll(".time")
        .at(minutes)
        .trigger("click");

      await timePicker
        .find(".hour-picker")
        .findAll(".time")
        .at(hour)
        .trigger("click");

      const datePicker = wrapper.find(".date-picker");

      await datePicker
        .findAll(".day")
        .at(day - 1)
        .trigger("click");

      expect(wrapper.find(".datetime-input").text()).toBe(
        `${day} Febrero 1975 ${hour}:${minutes}`
      );
    });
  });
});
