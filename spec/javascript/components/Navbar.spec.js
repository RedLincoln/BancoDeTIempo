import Vuetify from "vuetify";
import Vuex from "vuex";

import Navbar from "../../../app/javascript/components/Navbar.vue";
import Logo from "../../../app/javascript/components/Logo.vue";

import { createLocalVue, mount } from "@vue/test-utils";

describe("Navbar.vue", () => {
  const localVue = createLocalVue();
  localVue.component("Logo", Logo);
  let vuetify;
  let wrapper;
  let state;
  let store;

  beforeEach(() => {
    jest.resetAllMocks();
    localVue.use(Vuex);

    state = {
      user_name: "Michael",
      loggedIn: false,
    };
    store = new Vuex.Store({
      modules: {
        session: {
          namespaced: true,
          state,
        },
      },
    });

    vuetify = new Vuetify();
    wrapper = mount(Navbar, {
      localVue,
      vuetify,
      store,
      stubs: ["router-link"],
    });
  });

  it("renders properly", () => {
    expect(wrapper.html()).toMatchSnapshot();
  });

  it("Navbar Information when not logged in", () => {
    expect(wrapper.find('[data-testid="login-btn"]').exists()).toBeTruthy();
    expect(wrapper.find('[data-testid="sign_up-btn"]').exists()).toBeTruthy();
    expect(wrapper.find(".avatar").exists()).toBeFalsy();
  });
});
