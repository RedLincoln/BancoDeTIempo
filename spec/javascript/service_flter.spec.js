import { shallowMount } from "@vue/test-utils";
import axios from "axios";
import MockAdapter from "axios-mock-adapter";
import ServiceFilter from "../../app/javascript/parts/ServiceFilter/ServiceFilter";

describe("ServiceFilter.vue", () => {
  const categoriesResponse = [
    { name: "Asesoramiento", supcategory: "Atención a Personas" },
    { name: "Asesoramiento", supcategory: "Huertos y Jardines" },
    { name: "Programación", supcategory: "Informática" },
    { name: "Mudanza", supcategory: "Hogar" },
  ];

  const mocks = {
    $getJsonCategoriesPath: "/categories.json",
  };

  it("fitler by category properly display Categories", async () => {
    const wrapper = shallowMount(ServiceFilter, {
      mocks: mocks,
    });
    const axiosMock = new MockAdapter(axios);
    axiosMock
      .onGet(mocks.$getJsonCategoriesPath)
      .reply(200, categoriesResponse);

    await wrapper.find('[name="filter_category"]').trigger("focus");

    const expected = categoriesResponse.map((category) => category.name);
    const recived = wrapper
      .findAll(".categories_list")
      .wrappers.map((el) => el.text());

    expect(recived).toBe(expected);
  });
});
