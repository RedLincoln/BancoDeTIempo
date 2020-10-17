import { axiosInstance as axios } from "./axios";

export default {
  getAll() {
    return axios
      .get("/api/services/petition.json")
      .then((response) => response.data);
  },
};
