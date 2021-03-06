<template>
  <div id="notifications" class="dropdown">
    <div>
      <button type="button" class="toggle-button border rounded-circle mr-2"
      data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" @click="toggleDropdown">!</button>
      <span id="notifications-counter" class="position-absolute text-white">{{ counter }}</span>
    </div>
    <div>
    <div v-if="drop" id="notifications-list" class="dropdown-content dropdown-menu dropdown-menu-right show">
      <a v-for="(notification, index) in notifications" @click="updateNotification(index)"
           class="notification dropdown-item position-relative"
           :href="notification.link !== undefined ? notification.link : false" >
        <span v-if="!notification.seen" class="seen position-absolute text-primary font-weight-bold">.</span>
        <p>{{ notification.message }}<span class="target font-weight-bold">{{ notification.target }}</span></p>
        <p class="text-muted">{{ notification.time_ago }}</p>
      </a>
    </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import railsFlash from "../railsFlash";
import setupAxios from "../setupAxios";

export default {
  props: ['user_id'],
  data: function() {
    return {
      drop: false,
      counter: 0,
      notifications: []
    };
  },
  created() {
    this.fetchNotifications()
    this.connectWebSocket()
  },
  destroyed() {
    this.$cable.subscriptions.remove(this.channel)
  },
  methods: {
    toggleDropdown: function () {
      this.drop = !this.drop
    },
    connectWebSocket: function () {
      const vm = this
      this.channel = this.$cable.subscriptions.create(
              {
                channel: 'NotificationsChannel',
                user_id: this.user_id
              },
              {
                received: function (data) {
                  vm.counter++
                  vm.notifications.splice(0, 0, JSON.parse(data))
                }
              }
      )
    },
    addToNotifications: function (notifications){
      this.notifications = notifications
      this.counter = this.notifications.filter(notification => !notification.seen).length
    },
    fetchNotifications: function () {
      axios.get(this.$userNotificationsPath).then(response => {
        this.addToNotifications(response.data)
      })
    },
    updateNotification: function (index) {
      const notification = this.notifications[index]
      if (notification.seen) return
      axios.patch(this.$updateNotificationPath(notification.id), {seen: true},
              {headers: setupAxios.getDefaultHeader()}).then(response => {
        this.counter--
        this.notifications[index].seen = true
      }).catch(err => {
        railsFlash.alert(err.data.message)
      })
    }
  }
};
</script>

<style scoped>
  .seen {
    font-size: 1.5em;
    top: 50%;
    left: 5%;
    transform: translate(-100%, -80%);
  }
</style>
