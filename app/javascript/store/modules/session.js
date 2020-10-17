import SessionService from "../../services/session";

export const namespaced = true;

const { authenticate, register, updateUserInfo, logOut } = SessionService;

export const state = {
  user_name: "",
  user_id: "",
  user_balance: 0,
  role: "",
  avatar: null,
  loggedIn: false,
};

export const mutations = {
  LOG_IN(state) {
    state.loggedIn = true;
  },
  LOG_OUT(state) {
    state.loggedIn = false;
    state.user_name = "";
    state.role = "";
    state.avatar = null;
    state.user_id = "";
  },
  SET_USER_DATA(state, { name, role, avatar, id, balance }) {
    state.user_name = name;
    state.role = role;
    state.avatar = avatar;
    state.user_id = id;
    state.user_balance = balance;
  },
};

export const actions = {
  logIn({ commit }, authInfo) {
    return authenticate(authInfo).then((userData) => {
      commit("LOG_IN");
      commit("SET_USER_DATA", userData);
      return userData.name;
    });
  },
  logInWithToken({ commit, state }) {
    if (state.loggedIn) {
      updateUserInfo().then((userData) => {
        commit("LOG_IN");
        commit("SET_USER_DATA", userData);
      });
    }
  },
  signUp({}, formData) {
    return register(formData);
  },
  logOut({ commit }) {
    commit("LOG_OUT");
    logOut();
  },
};

export const getters = {};
