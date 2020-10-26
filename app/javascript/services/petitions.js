import { axiosInstance as axios } from "./axios";

export default {
  getAll() {
    return axios
      .get("/api/services/petition.json")
      .then((response) => response.data);
  },
  getPetition(id) {
    return axios.get(`/api/services/petition/${id}.json`);
  },
  updatePetition({ id, params }) {
    return axios.patch(`/api/services/petition/${id}`, params);
  },
  donePetition(id, rate) {
    return axios.post(`/api/services/petition/${id}/rate_client`, rate);
  },
  valuePetition(id, rate) {
    return axios.post(`/api/services/petition/${id}/rate_owner`, rate);
  },
};
