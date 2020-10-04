import Vuetify from "vuetify";
import Vuex from "vuex";

import { createLocalVue, mount } from "@vue/test-utils";
import Login from "../../../app/javascript/views/Login.vue";
import { actions } from "../../../app/javascript/store/modules/session";

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
  let actions;
  let store;

  beforeEach(() => {
    localVue.use(Vuex);

    actions = {
      logIn: jest.fn(),
    };
    store = new Vuex.Store({
      actions,
    });

    vuetify = new Vuetify();
    wrapper = mount(Login, {
      localVue,
      vuetify,
      store,
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

  it("successfuly logIn", async () => {
    const userInfo = {
      email: "michael@example.com",
      password: "password",
    };

    await wrapper.find('[data-testid="email-field"]').setValue(userInfo.email);
    await wrapper
      .find('[data-testid="password-field"]')
      .setValue(userInfo.password);
    await wrapper.find('[data-testid="submit-btn"]').trigger("click");

    expect(actions.logIn).toHaveBeenCalledTimes(1);
    expect(actions.logIn).toHaveBeenCalledWith(userInfo);
  });
});
