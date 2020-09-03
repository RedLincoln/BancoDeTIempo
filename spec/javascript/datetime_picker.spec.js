import { shallowMount } from "@vue/test-utils";
import DatetimePicker from "../../app/javascript/parts/DatetimePicker/DatetimePicker";

describe("DatetimePicker.vue", () => {
  it("initial state have no datetime selected", () => {
    const wrapper = shallowMount(DatetimePicker);
    expect(wrapper.find(".datetime-input").text()).toBe("");
  });
});
