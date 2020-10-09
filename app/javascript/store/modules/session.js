import SessionService from "../../services/session";

export const namespaced = true;

const { authenticate, register } = SessionService;

export const state = {
  user_name: "",
  loggedIn: false,
};

export const mutations = {
  LOG_IN(state) {
    state.loggedIn = true;
  },
  SET_USER_NAME(state, user_name) {
    state.user_name = user_name;
  },
};

export const actions = {
  logIn({ commit }, authInfo) {
    return authenticate(authInfo).then((user_name) => {
      commit("LOG_IN");
      commit("SET_USER_NAME", user_name);
      return user_name;
    });
  },
  signUp({}, formData) {
    return register(formData);
  },
};

export const getters = {};
