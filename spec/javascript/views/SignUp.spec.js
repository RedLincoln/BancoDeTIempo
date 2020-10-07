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

  beforeEach(() => {
    localVue.use(Vuex);

    vuetify = new Vuetify();
    wrapper = mount(SignUp, {
      localVue,
      vuetify,
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
});
