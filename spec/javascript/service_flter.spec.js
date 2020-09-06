import { shallowMount } from "@vue/test-utils";
import Vue from "vue";
import axios from "axios";
import ServiceFilter from "../../app/javascript/parts/ServiceFilter/ServiceFilter";

jest.mock("axios");

describe("ServiceFilter.vue", () => {
  const categoriesResponse = {
    data: [
      { name: "Asesoramiento", supcategory: "Atención a Personas" },
      { name: "Asesoramiento", supcategory: "Huertos y Jardines" },
      { name: "Programación", supcategory: "Informática" },
      { name: "Mudanza", supcategory: "Hogar" },
    ],
  };

  const mocks = {
    $getJsonCategoriesPath: "/categories.json",
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe("show and hide", () => {
    it("category filter list initial state is hidden", async () => {
      const wrapper = shallowMount(ServiceFilter);

      expect(wrapper.find(".categories_list").exists()).toBeFalsy();
    });

    it("show category filter on focus", async () => {
      axios.get.mockResolvedValue({});
      const wrapper = shallowMount(ServiceFilter, {
        mocks: mocks,
      });

      await wrapper.find("[name='filter_category']").trigger("focus");

      expect(wrapper.find(".categories_list").exists()).toBeTruthy();
    });

    it("hide category filter on blur", async () => {
      axios.get.mockResolvedValue({});
      const wrapper = shallowMount(ServiceFilter, {
        mocks: mocks,
      });

      await wrapper.find("[name='filter_category']").trigger("focus");

      await wrapper.find("[name='filter_category']").trigger("blur");

      expect(wrapper.find(".categories_list").exists()).toBeFalsy();
    });
  });

  describe("", () => {
    it("fitler by category properly display Categories", async () => {
      const spy = jest.spyOn(axios, "get");
      axios.get.mockResolvedValue(categoriesResponse);
      const wrapper = shallowMount(ServiceFilter, {
        mocks: mocks,
      });

      await wrapper.find('[name="filter_category"]').trigger("focus");

      await Vue.nextTick();

      const expected = categoriesResponse.data.map((category) => category.name);
      const recived = wrapper
        .find(".categories_list")
        .findAll("li")
        .wrappers.map((el) => el.text());

      expect(spy).toHaveBeenCalledTimes(1);
      expect(recived).toEqual(expected);
    });
  });
});
