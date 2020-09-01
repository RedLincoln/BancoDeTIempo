<template>
  <div id="notifications" class="dropdown">
    <div>
      <button type="button" class="toggle-button border rounded-circle" id="notification-list"
      data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" @click="toggleDropdown">!</button>
      <small id="notifications-counter" class="border rounded-circle position-absolute font-weight-bold">{{ counter }}</small>
    </div>
    <transition>
      <div v-if="drop" id="notifications-list" class="dropdown-content dropdown-menu dropdown-menu-right show">
        <div v-for="notification in notifications" class="notification dropdown-item">
          <p>{{ notification.message }}<span class="target font-weight-bold">{{ notification.target }}</span></p>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
import axios from 'axios'

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
                connected: function () {
                  console.log(`connected to notifications_${vm.user_id}`)
                },
                received: function (data) {
                  vm.counter++
                  console.log(data)
                  vm.notifications.push(JSON.parse(data))
                }
              }
      )
    },
    fetchNotifications: function () {
      axios.get(this.$userNotificationsPath).then(response => {
        console.log(response)
      })
    }

  }
};
</script>

<style scoped>
</style>
