import { axiosInstance as axios } from "./axios";

export default {
  getAll() {
    return axios.get("/api/services.json").then((response) => response.data);
  },
  getServices({ offset, limit, q, service_type, sort_order, category }) {
    const params = new URLSearchParams();
    params.append("offset", offset);
    params.append("limit", limit);
    params.append("q", q);
    params.append("service_type", service_type);
    params.append("sort_order", sort_order);
    params.append("category", category);

    return axios.get(`/api/services.json?${params.toString()}`);
  },
  getOffers() {
    return axios
      .get("/api/services.json?service_type=offer")
      .then((response) => response.data);
  },
  getDemand() {
    return axios
      .get("/api/services.json?service_type=demand")
      .then((response) => response.data);
  },
  getService(id) {
    return axios
      .get(`/api/services/${id}.json`)
      .then((response) => response.data.service);
  },
  updateService({ id, params }) {
    return axios.patch(`/api/services/${id}`, params);
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
