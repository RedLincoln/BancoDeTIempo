<template>
  <v-select
    :items="items"
    solo
    @change="$emit('change', $event)"
    return-object
    v-bind="$attrs"
  ></v-select>
</template>

<script>
export default {
  props: {
    items: {
      type: Array,
      required: true,
    },
  },
};
</script>
