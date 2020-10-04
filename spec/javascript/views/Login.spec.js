import Vuetify from "vuetify";

import { createLocalVue, mount } from "@vue/test-utils";
import Login from "../../../app/javascript/views/Login.vue";

describe("Login.vue", () => {
  const localVue = createLocalVue();
  let vuetify;
  let wrapper;

  beforeEach(() => {
    vuetify = new Vuetify();
    wrapper = mount(Login, {
      localVue,
      vuetify,
    });
  });

  it("renders properly", () => {
    expect(wrapper.html()).toMatchSnapshot();
  });

  it("have the necesary elements", () => {
    expect(wrapper.find('[data-testid="login-form"]').exists()).toBe(true);
    expect(wrapper.find('[data-testid="email-field"]').exists()).toBe(true);
    expect(wrapper.find('[data-testid="password-field"]').exists()).toBe(true);
    expect(wrapper.find('[data-testid="sumit-btn"]').exists()).toBe(true);
  });
});
