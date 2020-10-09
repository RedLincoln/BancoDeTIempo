import Vue from "vue";
import Vuex from "vuex";
import * as session from "./modules/session";
import * as flash from "./modules/flash";

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    session,
    flash,
  },
  mutations: {
    logout() {
      state.isLogged = false;
    },
    login() {
      state.isLogged = true;
    },
  },
});

export default store;
