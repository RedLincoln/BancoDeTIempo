import Vuetify from "vuetify";
import Vuex from "vuex";

import SignUp from "../../../app/javascript/views/SingUp.vue";
import Logo from "../../../app/javascript/components/Logo.vue";
import { createLocalVue, mount } from "@vue/test-utils";

describe("SignUp.vue", () => {
  const localVue = createLocalVue();
  localVue.component("Logo", Logo);
  let vuetify;
  let wrapper;
  let actions;
  let store;

  const data = {
    name: "Michale",
    information: "My name is Michael",
    email: "michael@example.com",
  };

  beforeEach(() => {
    jest.resetAllMocks();
    localVue.use(Vuex);

    actions = {
      SignUp: jest.fn(),
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
    wrapper = mount(SignUp, {
      localVue,
      vuetify,
      store,
    });
  });

  it("renders properly", () => {
    expect(wrapper.html()).toMatchSnapshot();
  });

  it("have all the necesary fields", () => {
    expect(wrapper.find('[data-testid="name-field"]').exists()).toBeTruthy();
    expect(
      wrapper.find('[data-testid="information-field"]').exists()
    ).toBeTruthy();
    expect(wrapper.find('[data-testid="email-field"]').exists()).toBeTruthy();
    expect(wrapper.find('[data-testid="avatar-field"]').exists()).toBeTruthy();
  });

  it("successful sign_up", async () => {
    actions.SignUp.mockResolvedValue();
    await wrapper.find('[data-testid="name-field"]').setValue(data.name);
    await wrapper
      .find('[data-testid="information-field"]')
      .setValue(data.information);
    await wrapper.find('[data-testid="email-field"]').setValue(data.email);

    await wrapper.vm.$nextTick();

    await wrapper.find('[data-testid="submit-button"]').trigger("click");

    expect(actions.logIn).toHaveBeenCalledWith(
      expect.objectContaining({}),
      expect.objectContaining(data)
    );
  });
});
