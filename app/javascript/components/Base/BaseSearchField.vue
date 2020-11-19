<template>
  <v-text-field
    prepend-inner-icon="mdi-magnify"
    filled
    rounded
    v-bind="$attrs"
    @input="$emit('input', $event)"
    @click:prepend-inner="$emit('search', $event)"
    @keyup.enter="$emit('search', $event)"
    clearable
  ></v-text-field>
</template>
