import Vue from "vue";
import Vuex from "vuex";
import * as session from "./modules/session";
import * as flash from "./modules/flash";
import * as users from "./modules/users";
import * as service from "./modules/service";
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

const store = new Vuex.Store({
  plugins: [
    createPersistedState({
      path: ["loggedIn"],
    }),
  ],
  modules: {
    session,
    flash,
    users,
    service,
  },
  state: {
    loading: false,
  },
  mutations: {
    SET_LOADING(state, loading) {
      state.loading = loading;
    },
  },
  actions: {
    setLoading({ commit }, loading) {
      commit("SET_LOADING", loading);
    },
  },
});

export default store;
