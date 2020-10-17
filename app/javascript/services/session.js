import { axiosInstance as axios } from "./axios";
import { removeToken, setToken } from "./jwt";

export default {
  authenticate(authData) {
    return axios.post("/api/session.json", authData).then((response) => {
      const userData = response.data;
      setToken(userData.token);
      return userData.user;
    });
  },
  register(formData) {
    return axios.post("/api/sign_up.json", formData);
  },
  logOut() {
    removeToken();
  },
  updateUserInfo() {
    return axios.post("/api/session/refresh").then((response) => {
      const userData = response.data;
      setToken(userData.token);
      return userData.user;
    });
  },
};
