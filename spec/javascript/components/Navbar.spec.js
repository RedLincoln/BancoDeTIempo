import Vuetify from "vuetify";
import Vuex from "vuex";

import Navbar from "../../../app/javascript/components/Navbar.vue";
import Logo from "../../../app/javascript/components/Logo.vue";

import { createLocalVue, mount } from "@vue/test-utils";

function getStoreByLogged(loggedIn) {
  const state = {
    user_name: "Michael",
    loggedIn,
  };
  return new Vuex.Store({
    modules: {
      session: {
        namespaced: true,
        state,
      },
    },
  });
}

describe("Navbar.vue", () => {
  const localVue = createLocalVue();
  localVue.component("Logo", Logo);
  let vuetify;
  let wrapper;

  beforeEach(() => {
    jest.resetAllMocks();
    localVue.use(Vuex);
  });

  it("renders properly", () => {
    vuetify = new Vuetify();
    wrapper = mount(Navbar, {
      localVue,
      vuetify,
      store: getStoreByLogged(false),
      stubs: ["router-link"],
    });
    expect(wrapper.html()).toMatchSnapshot();
  });

  it("information when not logged in", () => {
    vuetify = new Vuetify();
    wrapper = mount(Navbar, {
      localVue,
      vuetify,
      store: getStoreByLogged(false),
      stubs: ["router-link"],
    });
    expect(wrapper.find('[data-testid="login-btn"]').exists()).toBeTruthy();
    expect(wrapper.find('[data-testid="sign_up-btn"]').exists()).toBeTruthy();
    expect(wrapper.find(".avatar").exists()).toBeFalsy();
  });

  it("information when logged in", async () => {
    vuetify = new Vuetify();
    wrapper = mount(Navbar, {
      localVue,
      vuetify,
      store: getStoreByLogged(true),
      stubs: ["router-link"],
    });
    expect(wrapper.find('[data-testid="login-btn"]').exists()).toBeFalsy();
    expect(wrapper.find('[data-testid="sign_up-btn"]').exists()).toBeFalsy();
    expect(wrapper.find(".avatar").exists()).toBeTruthy();
  });
});
