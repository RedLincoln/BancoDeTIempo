import { axiosInstance as axios } from "./axios";

export default {
  getUser(user_id) {
    return axios.get(`/api/users/${user_id}.json`).then((response) => {
      return response.data;
    });
  },
  getUsers({ limit, offset }) {
    return axios
      .get(`/api/admin/users.json?limit=${limit}&offset=${offset}`)
      .then((response) => {
        return response.data;
      });
  },

  getUserNotifications() {
    return axios.get("/api/notifications").then((response) => {
      return response.data.notifications;
    });
  },

  markNotificationAsSeen(id) {
    return axios.get(`/api/notification/seen/${id}`);
  },
};
