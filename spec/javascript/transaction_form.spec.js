import { mount } from "@vue/test-utils";
import axios from "axios";
import Vue from "vue";
import TransactionForm from "../../app/javascript/parts/transaction_form";

jest.mock("axios");

describe("transaction_form.vue", () => {
  describe("", () => {
    let wrapper;
    let spy;
    const propsData = {
      service_id: 1,
    };

    const rejectResponse = {
      data: {
        message: "Errors",
        errors: {
          datetime: "Datetime cant be empty",
          duration: "Duration must be a integer",
        },
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
      wrapper.find("form.service-petition").trigger("submit");

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith(mocks.$createTransactionPath, {
        "": "",
        authenticity_token: "",
        transaction: {
          addition_information: "",
          datetime: " ",
          duration: "",
          service_id: propsData.service_id.toString(),
        },
        utf8: "✓",
      });
    });

    it("duration value can only be an integer", async () => {
      await wrapper.find("#transaction-duration").setValue("Haol");
      expect(wrapper.find("#transaction-duration").element.value).toBe("");
    });
  });
});
