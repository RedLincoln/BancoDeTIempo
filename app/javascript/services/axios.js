import axios from "axios";

const instance = axios.create({
  "Content-Type": "application/json",
});

instance.interceptors.request.use(
  (config) => {
    config.headers["X-CSRF-TOKEN"] = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content");
    return config;
  },
  (error) => {
    return Promise.reject(error.response);
  }
);

export default {
  axios: instance,
};
