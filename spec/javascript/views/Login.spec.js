import Vuetify from "vuetify";
import Vuex from "vuex";

import { createLocalVue, mount } from "@vue/test-utils";
import Login from "../../../app/javascript/views/Login.vue";
import Logo from "../../../app/javascript/components/Logo.vue";
import { actions } from "../../../app/javascript/store/modules/session";

const { logIn } = actions;

describe("Vuex have needed actions", () => {
  it("logIn", () => {
    expect(logIn).not.toBeUndefined();
  });
});

describe("Login.vue", () => {
  const localVue = createLocalVue();
  localVue.component("Logo", Logo);
  let vuetify;
  let wrapper;
  let actions;
  let store;

  let $router;

  const userInfo = {
    email: "michael@example.com",
    password: "password",
  };

  beforeEach(() => {
    jest.resetAllMocks();

    $router = {
      push: jest.fn(),
    };

    localVue.use(Vuex);

    actions = {
      logIn: jest.fn(),
    };
    store = new Vuex.Store({
      modules: {
        session: {
          namespaced: true,
          actions,
        },
      },
    });

    vuetify = new Vuetify();
    wrapper = mount(Login, {
      localVue,
      vuetify,
      store,
      mocks: {
        $router,
      },
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
    actions.logIn.mockResolvedValue();
    await wrapper.find('[data-testid="email-field"]').setValue(userInfo.email);
    await wrapper
      .find('[data-testid="password-field"]')
      .setValue(userInfo.password);
    await wrapper.find('[data-testid="submit-btn"]').trigger("click");

    expect(actions.logIn).toHaveBeenCalledTimes(1);
    expect(actions.logIn).toHaveBeenCalledWith(
      expect.objectContaining({}),
      expect.objectContaining(userInfo)
    );

    await wrapper.vm.$nextTick();
    expect($router.push).toHaveBeenCalledWith({ name: "home" });
  });

  it("bad logIn", async () => {
    const errorMessage = "Credentials problem";
    actions.logIn.mockRejectedValue({
      message: errorMessage,
    });

    await wrapper.find('[data-testid="email-field"]').setValue(userInfo.email);
    await wrapper
      .find('[data-testid="password-field"]')
      .setValue(userInfo.password);
    await wrapper.find('[data-testid="submit-btn"]').trigger("click");

    await wrapper.vm.$nextTick();
    await wrapper.vm.$nextTick();

    expect(wrapper.find('[data-testid="error-message"]').text()).toBe(
      errorMessage
    );
  });
});
