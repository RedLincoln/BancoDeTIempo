import ServiceService from "../../services/services";

const { getCategories, getTags } = ServiceService;

export const namespaced = true;

export const state = {
  tags: [],
  categories: [],
};

export const mutations = {
  SET_TAGS(state, tags) {
    state.tags = tags;
  },
  SET_CATEGORIES(state, categories) {
    state.categories = categories;
  },
};

export const actions = {
  fetchTagsAndCategories({ commit }) {
    return Promise.all([getCategories(), getTags()]).then(
      ([categories, tags]) => {
        commit("SET_TAGS", tags);
        commit("SET_CATEGORIES", categories);
        return;
      }
    );
  },
};
