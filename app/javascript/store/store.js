import Vue from "vue";
import Vuex from "vuex";
import * as session from "./modules/session";
import * as flash from "./modules/flash";
import * as users from "./modules/users";
import createPersistedState from "vuex-persistedstate";
import Cookies from "js-cookie";

Vue.use(Vuex);

const store = new Vuex.Store({
  plugins: [
    createPersistedState({
      path: ["loggedIn"],
      storage: {
        getItem: (key) => Cookies.get(key),
        setItem: (key, value) =>
          Cookies.set(key, value, { expires: 3, secure: true }),
        removeItem: (key) => Cookies.remove(key),
      },
    }),
  ],
  modules: {
    session,
    flash,
    users,
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
