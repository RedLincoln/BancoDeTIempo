import { axiosInstance as axios } from "./axios";
import { setToken } from "./jwt";

export default {
  authenticate(authData) {
    return axios
      .post("/api/session.json", authData)
      .then((response) => {
        const userData = response.data;
        setToken(userData.token);
        delete userData.token;
        return userData;
      })
      .catch((err) => {
        return err.response;
      });
  },
  register(formData) {
    return axios.post("/api/sign_up.json", formData);
  },
  logOut() {},
};
