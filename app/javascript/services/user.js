import { axiosInstance as axios } from "./axios";

export default {
  getUser(user_id) {
    return axios.get(`/api/users/${user_id}`).then((response) => {
      return response.data.user;
    });
  },
  getUsers() {
    return axios.get("/api/admin/users.json").then((response) => {
      return response.data.users;
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
