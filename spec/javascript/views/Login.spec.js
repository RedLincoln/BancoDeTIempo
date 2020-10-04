import Vuetify from "vuetify";

import { createLocalVue, mount } from "@vue/test-utils";
import Login from "../../../app/javascript/views/Login.vue";
import actions from "../../../app/javascript/store/modules/session";

const { logIn } = actions;

describe("Vuex have needed actions", () => {
  it("logIn", () => {
    expect(logIn).not.toBeUndefined();
  });
});

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
    expect(wrapper.find('[data-testid="submit-btn"]').exists()).toBe(true);
  });
});
