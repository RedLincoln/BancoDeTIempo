<template>
  <div id="notifications">
    <button type="button" class="toggle-button" @click="toggleDropdown">!</button>
    <transition>
      <div v-if="drop" class="dropdown-content"></div>
    </transition>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      drop: false
    };
  },
  methods: {
    toggleDropdown: function () {
      this.drop = !this.drop
    }
  }
};
</script>

<style scoped>
</style>
