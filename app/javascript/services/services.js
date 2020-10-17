import { axiosInstance as axios } from "./axios";

export default {
  getAll() {
    return axios.get("/api/services.json").then((response) => response.data);
  },

  getService(id) {
    return axios
      .get(`/api/services/${id}`)
      .then((response) => response.data.service);
  },

  getCategories() {
    return axios
      .get("/api/categories")
      .then((response) => response.data.categories);
  },

  getTags() {
    return axios.get("/api/tags").then((response) => response.data.tags);
  },

  createService(serviceData) {
    return axios
      .post("/api/services", serviceData)
      .then((response) => response.data.message);
  },

  makePetition(data) {
    return axios
      .post("/api/services/petition", data)
      .then((response) => response.data.message);
  },
};
