<template>
  <v-card elevation="0">
    <v-card-text
      ref="content"
      class="d-flex flex-column h400px overflow-y-scroll"
    >
      <v-list>
        <v-list-item
          v-for="(message, index) in messages"
          :key="index"
          class="mb-2"
        >
          <div
            v-if="message.author.id === user_id"
            class="d-flex justify-end w-100"
          >
            <div class="mr-2">
              <v-card
                tile
                class="pa-2 rounded-b-lg rounded-l-lg"
                color="light-green lighten-1"
              >
                {{ message.message }}
                <p class="m-0 text-right message-footer">
                  Yo, {{ formatDate(message.created_at) }}
                </p>
              </v-card>
            </div>
            <div><Avatar :avatar="message.author.avatar" :size="35" /></div>
          </div>
          <div v-else class="d-flex justify-start w-100">
            <div><Avatar :avatar="message.author.avatar" :size="35" /></div>
            <div class="ml-2">
              <v-card tile class="pa-2 rounded-b-lg rounded-r-lg">
                {{ message.message }}
                <p class="m-0 text-left message-footer">
                  {{ message.author.name }},
                  {{ formatDate(message.created_at) }}
                </p>
              </v-card>
            </div>
          </div>
        </v-list-item>
      </v-list>
    </v-card-text>

    <v-card-actions>
      <v-text-field
        v-model="message"
        @keyup.enter="sendMessage"
        @click:append="sendMessage"
        append-icon="mdi-send"
        placeholder="Enviar mensaje"
      ></v-text-field>
    </v-card-actions>
  </v-card>
</template>

<script>
import ChatService from "../services/chat";
import { mapState } from "vuex";

const { getMessages, sendMessage } = ChatService;

export default {
  props: {
    chat: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      messages: [],
      message: "",
    };
  },
  computed: mapState("session", ["user_id"]),
  channels: {
    chat: {
      received(data) {
        this.messages.push(data.message);
        if (data.message.author.id === this.user_id) {
          this.scrollTo();
        }
      },
    },
  },
  mounted() {
    getMessages(this.chat.id).then((messages) => {
      this.messages = messages;
      this.scrollTo();
    });
    this.$cable.subscribe(
      {
        channel: "RoomChannel",
        chat_room_id: this.chat.id,
      },
      "chat"
    );
  },
  methods: {
    scrollTo() {
      this.$nextTick(() => {
        this.$refs.content.scrollTo(0, this.$refs.content.scrollHeight);
      });
    },
    formatDate(dateTime) {
      const [date, time] = dateTime.split("T");
      const [year, month, day] = date.split("-");
      const [hours, minutes] = time.split(":");

      return `${day}/${month}/${year} ${hours}:${minutes}`;
    },
    sendMessage() {
      const holder = this.message;
      this.message = "";
      sendMessage({
        message: holder,
        chat_room_id: this.chat.id,
      });
    },
  },
};
</script>

<style scoped>
.message-footer {
  color: #676f77;
}
.overflow-y-scroll {
  overflow-y: scroll !important;
}
.h400px {
  height: 400px;
}
</style>
