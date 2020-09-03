import { shallowMount } from "@vue/test-utils";
import DatetimePicker from "../../app/javascript/parts/DatetimePicker/DatetimePicker";

// Spanish testing

describe("DatetimePicker.vue", () => {
  it("initial state have no datetime selected", () => {
    const wrapper = shallowMount(DatetimePicker);
    expect(wrapper.find(".datetime-input").text()).toBe("");
  });

  it("initial date selection is present Date", async () => {
    const wrapper = shallowMount(DatetimePicker);

    await wrapper.find(".datetime-input").trigger("click");

    const date = new Date("August 19, 1975 23:15:30");

    const datePicker = wrapper.find(".date-pricker");

    expect(datePicker.find(".month").text()).toBe("Agosto");
    expect(datePicker.find(".year").text()).toBe(date.getFullYear());
  });
});
