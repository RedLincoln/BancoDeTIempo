import { axiosInstance as axios } from "./axios";
import { setToken } from "./jwt";

export default {
  authenticate(authData) {
    return axios
      .post("/api/session.json", authData)
      .then((response) => {
        const { user_name, token } = response.data;
        setToken(token);
        return user_name;
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
