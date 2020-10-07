import SessionService from "../../services/session";

export const namespaced = true;

const { authenticate } = SessionService;

export const state = {};

export const mutations = {};

export const actions = {
  logIn({}, authInfo) {
    return authenticate(authInfo);
  },
};

export const getters = {};
