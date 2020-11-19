import ServicesService from "../../services/services";

const { getServices, getCategories } = ServicesService;

export const namespaced = true;

export const state = {
  services: [],
  perPage: 10,
  totalServices: 0,
  categories: [],
  tags: [],
};

export const mutations = {
  SET_SERVICES(state, services) {
    state.services = services;
  },
  SET_TOTAL(state, total) {
    state.totalServices = total;
  },
  SET_CATEGORIES(state, categories) {
    state.categories = categories;
  },
};

export const actions = {
  fetch(
    { commit, state, dispatch },
    { page, q, service_type, sort_order, category }
  ) {
    dispatch("setLoading", true, { root: true }).then(() => {
      getServices({
        limit: state.perPage,
        offset: page * state.perPage,
        q,
        service_type,
        sort_order,
        category,
      }).then((response) => {
        commit("SET_SERVICES", response.data.services);
        commit("SET_TOTAL", response.data.total);
        dispatch("setLoading", false, { root: true });
      });
    });
  },
  fetchCategories({ commit, dispatch }) {
    return dispatch("setLoading", true, { root: true }).then(() => {
      getCategories().then((categories) => {
        commit("SET_CATEGORIES", categories);
        dispatch("setLoading", false, { root: true });
      });
    });
  },
};
