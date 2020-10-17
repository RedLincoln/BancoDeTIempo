import UserService from "../../services/user";

const { getUsers } = UserService;

export const namespaced = true;

export const state = {
  users: [],
  perPage: 10,
  total: 0,
};

export const mutations = {
  SET_USERS(state, { users, total }) {
    state.users = users;
    state.total = total;
  },
};

export const actions = {
  fetch({ commit, state }, page) {
    getUsers({
      limit: state.perPage,
      offset: page * state.perPage,
    }).then((data) => {
      commit("SET_USERS", data);
    });
  },
};
