import axios from "axios";

export const axiosInstance = axios.create({
  "Content-Type": "application/json",
});

axiosInstance.interceptors.request.use(
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
