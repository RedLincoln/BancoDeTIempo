<template>
  <v-container fluid fill-height>
    <v-row justify="center" align="center">
      <v-col cols="12" md="6">
        <v-card class="mx-auto px-4">
          <Logo maxWidth="100%" dark />
          <slot name="title"></slot>
          <slot name="form"></slot>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
