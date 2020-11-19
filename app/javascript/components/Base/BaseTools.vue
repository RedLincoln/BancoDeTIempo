<template>
  <div>
    <v-btn text small @click="expand = !expand">
      <v-icon>
        mdi-tools
      </v-icon>
      Herramientas
    </v-btn>
    <v-expand-transition>
      <div v-show="expand">
        <slot></slot>
      </div>
    </v-expand-transition>
  </div>
</template>

<script>
export default {
  data() {
    return {
      expand: false,
    };
  },
};
</script>
