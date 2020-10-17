<template>
  <div class="text-center">
    <v-menu offset-y>
      <template v-slot:activator="{ on, attrs }">
        <v-badge
          :content="notSeenNotifications.length"
          :value="notSeenNotifications.length"
          color="green"
          overlap
        >
          <v-icon v-bind="attrs" v-on="on" id="notifications-icon">
            mdi-bell
          </v-icon>
        </v-badge>
      </template>
      <v-list>
        <router-link
          :to="notification.link"
          v-for="(notification, index) in notifications"
          :key="index"
        >
          <v-list-item @click="markAsSeen(index)">
            <v-list-item-content two-line>
              <v-list-item-title
                >{{ notification.message }}
                {{ notification.target }}</v-list-item-title
              >
              <v-list-item-subtitle>{{
                notification.time_ago
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </router-link>
      </v-list>
    </v-menu>
  </div>
</template>

<script>
import { mapState } from "vuex";
import UserService from "../services/user";

const { getUserNotifications, markNotificationAsSeen } = UserService;

export default {
  data() {
    return {
      notifications: [],
    };
  },
  computed: {
    notSeenNotifications() {
      return this.notifications.filter((notification) => !notification.seen);
    },
    ...mapState("session", ["user_id", "loggedIn"]),
  },
  channels: {
    notifications: {
      received(notification) {
        this.notifications.splice(0, 0, JSON.parse(notification));
      },
    },
  },
  mounted() {
    if (this.loggedIn) {
      getUserNotifications().then((notifications) => {
        this.notifications = notifications;
      });
      this.$cable.subscribe(
        {
          channel: "NotificationsChannel",
          user_id: this.user_id,
        },
        "notifications"
      );
    }
  },
  methods: {
    markAsSeen(index) {
      markNotificationAsSeen(this.notifications[index].id).then(() => {
        this.notifications[index].seen = true;
      });
    },
  },
};
</script>

<style scoped>
#notifications-icon:hover {
  cursor: pointer;
}
</style>
