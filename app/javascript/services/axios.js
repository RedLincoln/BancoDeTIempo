import axios from "axios";
import { getToken } from "./jwt";

export const axiosInstance = axios.create({
  "Content-Type": "application/json",
});

axiosInstance.interceptors.request.use(
  (config) => {
    config.headers["X-CSRF-TOKEN"] = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content");
    config.headers["Authorization"] = "Bearer " + getToken();
    return config;
  },
  (error) => {
    return Promise.reject(error.response);
  }
);
