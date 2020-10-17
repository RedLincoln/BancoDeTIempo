import { axiosInstance as axios } from "./axios";

export default {
  getChats() {
    return axios
      .get("/api/chat_rooms")
      .then((response) => response.data.chat_rooms);
  },
  sendMessage({ message, chat_room_id }) {
    axios.post(`/api/chat_rooms/message/${chat_room_id}`, { message });
  },
  getMessages(chat_room_id) {
    return axios
      .get(`/api/chat_rooms/message/${chat_room_id}`)
      .then((response) => response.data.messages);
  },
};
