import { axiosInstance as axios } from "./axios";

export default {
  getChats() {
    return axios
      .get("/api/chat_rooms.json")
      .then((response) => response.data.chat_rooms);
  },
  getChat(chat_room_id) {
    return axios
      .get(`/api/chat_rooms/${chat_room_id}.json`)
      .then((response) => response.data.chat);
  },
  sendMessage({ message, chat_room_id }) {
    axios.post(`/api/chat_rooms/message/${chat_room_id}`, { message });
  },
  getMessages(chat_room_id) {
    return axios
      .get(`/api/chat_rooms/message/${chat_room_id}`)
      .then((response) => response.data.messages);
  },
  resetNotReadCount(chat_room_id) {
    return axios.post(`/api/chat_room/${chat_room_id}/reset_read_count`);
  },
};
