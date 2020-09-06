import { shallowMount } from "@vue/test-utils";
import axios from "axios";
import Vue from "vue";
import ServiceFilter from "../../app/javascript/parts/ServiceFilter/ServiceFilter";

jest.mock("axios");

describe("ServiceFilter.vue", () => {
  let wrapper;
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
    wrapper = shallowMount(ServiceFilter, {
      mocks: mocks,
    });
  });

  describe("show and hide", () => {
    it("category filter list initial state is hidden", async () => {
      expect(wrapper.find(".categories_list").exists()).toBeFalsy();
    });

    it("show category filter on focus", async () => {
      axios.get.mockResolvedValue({});

      await wrapper.find("[name='filter_category']").trigger("focus");

      expect(wrapper.find(".categories_list").exists()).toBeTruthy();
    });

    it("hide category filter on blur", async () => {
      await wrapper.find("[name='filter_category']").trigger("focus");

      await wrapper.find("[name='filter_category']").trigger("blur");

      expect(wrapper.find(".categories_list").exists()).toBeFalsy();
    });
  });

  describe("", () => {
    it("fitler by category properly display Categories", async () => {
      const spy = jest.spyOn(axios, "get");
      axios.get.mockResolvedValue(categoriesResponse);

      await wrapper.find('[name="filter_category"]').trigger("focus");

      await Vue.nextTick();
      const expected = categoriesResponse.data.map((category) => category.name);
      const received = wrapper
        .find(".categories_list")
        .findAll("li")
        .wrappers.map((el) => el.text());

      expect(spy).toHaveBeenCalledTimes(1);
      expect(received).toEqual(expected);
    });

    it("can click on categories to filter", async () => {
      const categoryIndex = 2;
      await wrapper.find('[name="filter_category"]').trigger("focus");

      await Vue.nextTick();

      await wrapper
        .find(".categories_list")
        .findAll("li")
        .at(categoryIndex)
        .trigger("click");

      const expected = categoriesResponse.data[categoryIndex].name;
      const received = wrapper.find("[name='filter_category']").element.value;

      expect(received).toEqual(expected);
    });

    it("filling in category_filter input changes category_list", async () => {
      const resultFilter = {
        data: [
          { name: "Asesoramiento", supcategory: "Atención a Personas" },
          { name: "Asesoramiento", supcategory: "Huertos y Jardines" },
        ],
      };
      const spy = jest.spyOn(axios, "get");
      axios.get.mockResolvedValue(categoriesResponse);

      await wrapper.find('[name="filter_category"]').trigger("focus");
      spy.mockRestore();

      axios.get.mockResolvedValue(resultFilter);
      await wrapper.find('[name="filter_category"]').setValue("Ase");
      await Vue.nextTick();

      const expected = resultFilter.data.map((category) => category.name);
      const received = wrapper
        .find(".categories_list")
        .findAll("li")
        .wrappers.map((el) => el.text());

      expect(spy).toHaveBeenCalledWith(mocks.$getJsonCategoriesPath, {
        category_filter: "Ase",
      });
      expect(received).toEqual(expected);
    });
  });
});
