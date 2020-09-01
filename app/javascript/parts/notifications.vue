<template>
  <div id="notifications">
    <div>
      <button type="button" class="toggle-button" @click="toggleDropdown">!</button>
      <span id="notifications-counter">{{ counter }}</span>
    </div>
    <transition>
      <div v-if="drop" id="notifications-list" class="dropdown-content">
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
                  console.log(data)
                }
              }
      )
    }
  }
};
</script>

<style scoped>
</style>
