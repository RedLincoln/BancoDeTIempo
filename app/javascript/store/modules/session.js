import SessionService from "../../services/session";

export const namespaced = true;

const { authenticate, register } = SessionService;

export const state = {
  user_name: "",
  role: "",
  avatar: null,
  loggedIn: false,
};

export const mutations = {
  LOG_IN(state) {
    state.loggedIn = true;
  },
  SET_USER_DATA(state, { user_name, role, avatar }) {
    state.user_name = user_name;
    state.role = role;
    state.avatar = avatar;
  },
};

export const actions = {
  logIn({ commit }, authInfo) {
    return authenticate(authInfo).then((userData) => {
      commit("LOG_IN");
      commit("SET_USER_DATA", userData);
      return userData.user_name;
    });
  },
  signUp({}, formData) {
    return register(formData);
  },
};

export const getters = {};
