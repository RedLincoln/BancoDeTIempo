import { mount } from "@vue/test-utils";
import axios from "axios";
import Vue from "vue";
import ServiceFilter from "../../app/javascript/parts/ServiceFilter/ServiceFilter";

jest.mock("axios");

describe("ServiceFilter.vue", () => {
  let wrapper;
  let spy;
  const categoriesResponse = {
    data: [
      { name: "Asesoramiento", supcategory: "Atención a Personas" },
      { name: "Asesoramiento", supcategory: "Huertos y Jardines" },
      { name: "Programación", supcategory: "Informática" },
      { name: "Mudanza", supcategory: "Hogar" },
    ],
  };

  const resultFilter = {
    data: [
      { name: "Asesoramiento", supcategory: "Atención a Personas" },
      { name: "Asesoramiento", supcategory: "Huertos y Jardines" },
    ],
  };
  const mocks = {
    $getJsonCategoriesPath: "/categories.json",
  };

  beforeEach(() => {
    jest.clearAllMocks();
    jest.useFakeTimers();
    spy = jest.spyOn(axios, "get");
    axios.get.mockResolvedValue(categoriesResponse);
  });

  describe("show and hide", () => {
    beforeEach(() => {
      wrapper = mount(ServiceFilter, {
        mocks: mocks,
      });
    });

    it("category filter list initial state is hidden", async () => {
      expect(wrapper.find(".content_list").exists()).toBeFalsy();
    });

    it("show category filter on focus", async () => {
      axios.get.mockResolvedValue({});

      await wrapper.find("[name='filter_category']").trigger("focus");

      expect(wrapper.find(".content_list").exists()).toBeTruthy();
    });

    it("hide category filter on click of close bottom", async () => {
      await wrapper.find("[name='filter_category']").trigger("focus");

      await wrapper.find(".close_filter").trigger("click");

      expect(wrapper.find(".content_list").exists()).toBeFalsy();
    });
  });

  describe("", () => {
    beforeEach(() => {
      wrapper = mount(ServiceFilter, {
        mocks: mocks,
      });
    });

    it("fitler by category properly display Categories", async () => {
      await wrapper.find('[name="filter_category"]').trigger("focus");
      await Vue.nextTick();

      const expected = categoriesResponse.data.map((category) => category.name);
      const received = wrapper
        .find(".content_list")
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
        .find(".content_list")
        .findAll("li")
        .at(categoryIndex)
        .trigger("click");

      const expected = categoriesResponse.data[categoryIndex].name;
      const received = wrapper.find("[name='filter_category']").element.value;

      expect(received).toEqual(expected);
    });

    it("once the user stop typing in the input, category_list is filtered", async () => {
      await wrapper.find('[name="filter_category"]').trigger("focus");
      spy.mockRestore();

      axios.get.mockResolvedValue(resultFilter);
      await wrapper.find('[name="filter_category"]').setValue("As");
      await wrapper.find('[name="filter_category"]').setValue("Ase");
      jest.runAllTimers();
      await Vue.nextTick();

      const expected = resultFilter.data.map((category) => category.name);
      const received = wrapper
        .find(".content_list")
        .findAll("li")
        .wrappers.map((el) => el.text());

      expect(setTimeout).toHaveBeenCalledTimes(2);
      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith(mocks.$getJsonCategoriesPath, {
        params: {
          category_filter: "Ase",
        },
      });
      expect(received).toEqual(expected);
    });
  });

  describe("initial field value", () => {
    const { location } = window;

    beforeEach(() => {
      delete window.location;
    });

    afterEach(() => {
      window.location = location;
    });

    it("must be the one in window.location.search", () => {
      window.location = {
        search: "?filter_category=initial",
      };
      wrapper = mount(ServiceFilter, {
        mocks: mocks,
      });
      expect(wrapper.find('[name="filter_category"]').element.value).toBe(
        "initial"
      );
    });

    it("if filter_category is not in search_string then input is empty", () => {
      window.location = {
        search: "",
      };
      wrapper = mount(ServiceFilter, {
        mocks: mocks,
      });
      expect(wrapper.find('[name="filter_category"]').element.value).toBe("");
    });
  });
});
