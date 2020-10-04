import Vuetify from "vuetify";

import { createLocalVue, mount } from "@vue/test-utils";
import Login from "../../../app/javascript/views/Login.vue";

describe("Login.vue", () => {
  const localVue = createLocalVue();
  let vuetify;

  beforeEach(() => {
    vuetify = new Vuetify();
  });

  it("renders properly", () => {
    const wrapper = mount(Login, {
      localVue,
      vuetify,
    });

    expect(wrapper.html()).toMatchSnapshot();
  });
});
