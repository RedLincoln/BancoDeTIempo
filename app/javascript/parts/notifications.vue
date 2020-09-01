<template>
  <div id="notifications">
    <div>
      <button type="button" class="toggle-button" @click="toggleDropdown">!</button>
      <span id="notifications-counter">{{ counter }}</span>
    </div>
    <transition>
      <div v-if="drop" id="notifications-list" class="dropdown-content d-flex row">
        <div v-for="notification in notifications" class="notification">
          <p>{{ notification.message }}<span class="target">{{ notification.target }}</span></p>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>

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
                  vm.notifications.push(JSON.parse(data))
                }
              }
      )
    }
  }
};
</script>

<style scoped>
</style>
