import { mount } from "@vue/test-utils";
import axios from "axios";
import TransactionForm from "../../app/javascript/parts/transaction_form";
import DatetimePicker from "../../app/javascript/parts/DatetimePicker/DatetimePicker";

jest.mock("axios");

describe("transaction_form.vue", () => {
  describe("", () => {
    let wrapper;
    let spy;
    const propsData = {
      service_id: 1,
    };

    const rejectResponse = {
        message: "Errors",
        errors: {
          datetime: "Datetime cant be empty",
          duration: "Duration must be a integer",
      },
    };

    const mocks = {
      $createTransactionPath: "/transactions.js",
      $getCSRFToken: () => "",
    };

    beforeEach(() => {
      jest.clearAllMocks();
      spy = jest.spyOn(axios, "post");
      wrapper = mount(TransactionForm, {
        propsData,
        mocks,
      });
    });

    it("expect send petition behaviour", () => {
      axios.post.mockResolvedValue("");
      wrapper.find(".transaction-datetime").setValue("2020/07/07 10:00");
      wrapper.find("form.service-petition").trigger("submit");

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith(mocks.$createTransactionPath, {
        "": "",
        authenticity_token: "",
        transaction: {
          addition_information: "",
          datetime: new Date(2020, 7, 7, 10, 0).getTime(),
          duration: "0",
          service_id: propsData.service_id.toString(),
        },
        utf8: "✓",
      });
    });

    it("duration value can only be an integer", async () => {
      wrapper.find("#transaction-duration").element.value = "Haol";
      await wrapper.find("#transaction-duration").trigger("input");
      expect(wrapper.find("#transaction-duration").element.value).toBe("0");
    });

    it("duration value remove left side zeros", async () => {
      wrapper.find("#transaction-duration").element.value = "01";
      await wrapper.find("#transaction-duration").trigger("input");
      expect(wrapper.find("#transaction-duration").element.value).toBe("1");
    });

    it("duration input set to 0 when there is only one element and u delete it", async () => {
      wrapper.find("#transaction-duration").element.value = "01";
      await wrapper.find("#transaction-duration").trigger("input");
      expect(wrapper.find("#transaction-duration").element.value).toBe("1");
      await wrapper.find("#transaction-duration").trigger("keydown.delete");
      expect(wrapper.find("#transaction-duration").element.value).toBe("0");
    });

    it("duration value can only be positive", async () => {
      wrapper.find("#transaction-duration").element.value = "-";
      await wrapper.find("#transaction-duration").trigger("input");
      wrapper.find("#transaction-duration").element.value = "1";
      await wrapper.find("#transaction-duration").trigger("input");
      expect(wrapper.find("#transaction-duration").element.value).toBe("1");
    });

    it("duration value must be less of equal to 23", async () => {
      wrapper.find("#transaction-duration").element.value = "2";
      await wrapper.find("#transaction-duration").trigger("input");
      wrapper.find("#transaction-duration").element.value = "24";
      await wrapper.find("#transaction-duration").trigger("input");
      expect(wrapper.find("#transaction-duration").element.value).toBe("2");
    });

    it("duration show time range when time is emitted", async () => {
      const time = 8 * 60 * 60;
      wrapper.find("#transaction-duration").element.value = "2";
      await wrapper.find("#transaction-duration").trigger("input");

      await wrapper
        .findComponent(DatetimePicker)
        .vm.$emit("selected-time", time);

      expect(wrapper.find(".duration-time-range").text()).toBe("8:00 - 10:00");
    });

    it("duration show time range when time is emitted with minutes", async () => {
      const time = 8 * 60 * 60 + 45 * 60;

      wrapper.find("#transaction-duration").element.value = "1";
      await wrapper.find("#transaction-duration").trigger("input");

      await wrapper
        .findComponent(DatetimePicker)
        .vm.$emit("selected-time", time);

      expect(wrapper.find(".duration-time-range").text()).toBe("8:45 - 9:45");
    });

    it("duration change time range on duration change", async () => {
      const time = 8 * 60 * 60 + 45 * 60;

      await wrapper
        .findComponent(DatetimePicker)
        .vm.$emit("selected-time", time);

      wrapper.find("#transaction-duration").element.value = "1";
      await wrapper.find("#transaction-duration").trigger("input");

      expect(wrapper.find(".duration-time-range").text()).toBe("8:45 - 9:45");
    });
  });
});
