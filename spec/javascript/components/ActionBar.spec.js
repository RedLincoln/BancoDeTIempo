import Vuetify from "vuetify";
import Vuex from "vuex";

import ActionBar from "../../../app/javascript/components/ActionBar.vue";

import { createLocalVue, mount } from "@vue/test-utils";

function getStoreByLogged({ loggedIn, role }) {
  const state = {
    user_name: "Michael",
    role,
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
  let vuetify;
  let wrapper;

  const loggedAdmin = () => {
    vuetify = new Vuetify();
    wrapper = mount(ActionBar, {
      localVue,
      vuetify,
      store: getStoreByLogged({ loggedIn: true, role: "admin" }),
      stubs: ["router-link"],
    });
  };

  beforeEach(() => {
    jest.resetAllMocks();
    localVue.use(Vuex);
  });

  it("renders properly", () => {
    loggedAdmin();
    expect(wrapper.html()).toMatchSnapshot();
  });

  it("have a user navigation link for admins", () => {
    loggedAdmin();
    expect(
      wrapper.find('[data-testid="admin-users-tab"]').exists()
    ).toBeTruthy();
  });
});
