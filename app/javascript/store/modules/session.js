import SessionService from "../../services/session";

export const namespaced = true;

const { authenticate, register } = SessionService;

export const state = {};

export const mutations = {};

export const actions = {
  logIn({}, authInfo) {
    return authenticate(authInfo);
  },
  signUp({}, formData) {
    return register(formData);
  },
};

export const getters = {};
