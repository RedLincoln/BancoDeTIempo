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
        .at(day)
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
        .at(day)
        .trigger("click");

      expect(wrapper.find(".datetime-input").text()).toBe("");
    });
  });
});
