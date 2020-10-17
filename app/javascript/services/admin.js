import { axiosInstance as axios } from "./axios";

export default {
  getUsers() {
    return axios.get("/api/admin/users.json").then((response) => {
      return response.data.users;
    });
  },
  confirmUser(user) {
    return axios.post("/api/admin/users/confirm", user);
  },
  deleteUser(user) {
    return axios.post("/api/admin/users/delete", user);
  },
};
