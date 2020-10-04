import Vue from "vue";
import Vuex from "vuex";
import * as session from "./modules/session";

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    session,
  },
  state: {
    isLogged: false,
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
