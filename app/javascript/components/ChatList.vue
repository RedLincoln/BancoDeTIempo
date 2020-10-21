<template>
  <v-menu :close-on-content-click="false" top offset-y>
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        v-on="on"
        v-bind="attrs"
        color="primary"
        elevation="2"
        fab
        fixed
        right
        bottom
      >
        <v-icon>mdi-message</v-icon>
      </v-btn>
    </template>
    <v-card width="400px" height="550px" class="d-flex flex-column">
      <v-card-title class="p-0">
        <v-toolbar color="deep-purple" dark>
          <v-toolbar-title>
            <v-icon v-show="!showChatList" @click="showChatList = true"
              >mdi-arrow-left-thick</v-icon
            >
            {{ titleText }}
          </v-toolbar-title>
        </v-toolbar>
      </v-card-title>

      <div v-if="showChatList">
        <v-text-field
          hide-details
          filled
          prepend-inner-icon="mdi-magnify"
          @keyup="search"
          placeholder="Buscar"
        ></v-text-field>
        <v-list>
          <template v-for="(chat, index) in filteredChats">
            <v-hover v-slot:default="{ hover }">
              <v-list-item
                @click="transitionToChat(index)"
                :key="index"
                two-line
                :class="{ 'hover-chat-item': hover }"
                class="d-flex justify-space-between border-bottom"
              >
                <v-list-item-content>
                  <v-list-item-title>{{ chat.name }}</v-list-item-title>
                  <v-list-item-subtitle v-if="!chat.last_chat_room_message"
                    >{{ participants(chat) }}
                  </v-list-item-subtitle>
                  <v-list-item-subtitle v-else>
                    {{ formatMessage(chat.last_chat_room_message) }}
                  </v-list-item-subtitle>
                </v-list-item-content>
                <v-icon
                  v-show="chat.message_not_read_count == 0"
                  :class="{ 'show-btns': hover }"
                  color="transparent"
                  >mdi-arrow-right</v-icon
                >
                <v-btn
                  fab
                  v-show="chat.message_not_read_count > 0"
                  color="green"
                  dark
                  small
                  >{{ chat.message_not_read_count }}</v-btn
                >
              </v-list-item>
            </v-hover>
          </template>
        </v-list>
      </div>
      <Chat v-if="!showChatList" :chat="selectedChat" :key="2" />
    </v-card>
  </v-menu>
</template>

<script>
import ChatService from "../services/chat";
import { mapState } from "vuex";
import chat from "../services/chat";
import Chat from "./Chat";

const { getChats, resetNotReadCount, getChat } = ChatService;

export default {
  components: {
    Chat,
  },
  data() {
    return {
      chats: [],
      filteredChats: [],
      showChatList: true,
      selectedChat: null,
      index: -1,
    };
  },
  computed: {
    titleText() {
      return !this.showChatList && this.index > -1
        ? this.chats[this.index].name
        : "Chats";
    },
    ...mapState("session", ["user_id", "loggedIn"]),
  },
  channels: {
    user_chat: {
      received({ action, chat_room_id }) {
        switch (action) {
          case "new":
            break;
          case "update":
            this.chats = this.chats.filter((chat) => chat.id !== chat_room_id);
            getChat(chat_room_id).then((chat) => {
              this.chats.unshift(chat);
            });
            break;
          case "delete":
            break;
        }
      },
    },
  },
  watch: {
    chats(val) {
      this.filteredChats = val;
    },
  },
  mounted() {
    if (this.loggedIn) {
      this.$cable.subscribe(
        {
          channel: "UserChatChannel",
          user_id: this.user_id,
        },
        "user_chat"
      );
      this.getChats();
    }
  },
  methods: {
    search(event) {
      this.filteredChats = this.chats.filter((chat) =>
        chat.name.toLowerCase().includes(event.target.value.toLowerCase())
      );
    },
    getChats() {
      getChats().then((chats) => (this.chats = chats));
    },
    participants(chat) {
      return chat.users
        .map((user) => {
          return user.id === this.user_id ? "Yo" : user.name;
        })
        .join(", ");
    },
    transitionToChat(index) {
      this.index = index;
      this.selectedChat = this.chats[index];
      resetNotReadCount(this.selectedChat.id).then(() => {
        this.selectedChat.message_not_read_count = 0;
      });
      this.showChatList = false;
    },
    formatMessage(message) {
      const author =
        message.author.id === this.user_id ? "Yo" : message.author.name;
      return `${author}: ${message.message}`;
    },
  },
};
</script>

<style scoped>
.hover-chat-item {
  background-color: #f5f5f5f5;
  cursor: pointer;
}

.show-btns {
  color: initial !important;
}
</style>
