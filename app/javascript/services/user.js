import { axiosInstance as axios } from "./axios";

export default {
  getUser(user_id) {
    return axios.get(`/api/users/${user_id}.json`).then((response) => {
      return response.data;
    });
  },
  getUsers({ limit, offset, q, role }) {
    const params = new URLSearchParams();
    params.append("limit", limit);
    params.append("offset", offset);
    params.append("q", !!q ? q : "");
    params.append("role", role);
    return axios
      .get(`/api/admin/users.json?${params.toString()}`)
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
