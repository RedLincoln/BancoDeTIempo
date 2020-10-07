import { axiosInstance as axios } from "./axios";

export default {
  authenticate(authInformation) {
    axios
      .post("/users/sign_in.json", authInformation)
      .then((response) => console.log(response))
      .catch((err) => {
        console.log(err);
      });
  },
  register() {},
  logOut() {},
};
