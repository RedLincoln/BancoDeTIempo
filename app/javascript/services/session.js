import { axiosInstance as axios } from "./axios";

export default {
  authenticate(authInformation) {
    axios
      .post("/api/session.json", authInformation)
      .then((response) => console.log(response))
      .catch((err) => {
        console.log(err);
      });
  },
  register() {},
  logOut() {},
};
