import PetitionService from "../../services/petitions";

const { getPetitions } = PetitionService;

export const namespaced = true;

export const state = {
  petitions: [],
  total: 0,
};

export const mutations = {
  SET_PETITIONS(state, petitions) {
    state.petitions = petitions;
  },
  SET_TOTAL(state, total) {
    state.total = total;
  },
};

export const actions = {
  fetch({ commit, dispatch }, { q }) {
    return dispatch("setLoading", true, { root: true }).then(() => {
      getPetitions({ q }).then((data) => {
        commit("SET_PETITIONS", data.petitions);
        commit("SET_TOTAL", data.total);
        dispatch("setLoading", false, { root: true });
      });
    });
  },
};

export const getters = {
  all(state) {
    return state.petitions;
  },
  clients: (state) => (user_id) => {
    return state.petitions.filter((petition) => petition.client.id === user_id);
  },
  owners: (state) => (user_id) => {
    return state.petitions.filter((petition) => petition.client.id !== user_id);
  },
};
