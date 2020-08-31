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
      this.channel = this.$cable.subscriptions.create(
              {
                channel: 'NotificationsChannel',
                user_id: this.user_id
              },
              {
                received: function (data) {
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
