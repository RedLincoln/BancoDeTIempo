export const namespaced = true;

export const state = {
  flashs: [],
};

export const mutations = {
  APPEND_FLASH(state, flash) {
    state.flashs.push(flash);
  },
  REMOVE_FIRST_FLASH(state) {
    state.flashs.shift();
  },
  RESET_FLASH(state) {
    state.flashs = [];
  },
};

export const actions = {
  removeAllFlash({ commit }) {
    commit("RESET_FLASH");
  },
  addFlash({ commit }, flash) {
    commit("APPEND_FLASH", flash);
  },
};
