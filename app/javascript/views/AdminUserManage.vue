<template>
  <v-list>
    <template v-for="(user, index) in users">
      <v-list-item :key="user.email">
        <v-list-item-avatar>
          <v-img :src="getAvatar(user.avatar)"></v-img>
        </v-list-item-avatar>

        <v-list-item-content>
          <v-list-item-title>{{ user.name }}</v-list-item-title>
          <v-list-item-subtitle>{{ user.email }}</v-list-item-subtitle>
        </v-list-item-content>

        <v-list-item-action>
          <v-btn
            v-if="!user.confirmed"
            color="success"
            @click="confirmUser(index)"
          >
            Confirmar
          </v-btn>
          <v-btn color="secundary" @click="deleteUser(index)">
            Eliminar
          </v-btn>
        </v-list-item-action>
      </v-list-item>
      <v-divider :key="index"> </v-divider>
    </template>
  </v-list>
</template>

<script>
import AdminService from "../services/admin";
import defaultAvatar from "images/default-avatar.jpg";

const { getUsers, confirmUser, deleteUser } = AdminService;

export default {
  data() {
    return {
      users: [],
    };
  },
  created() {
    getUsers()
      .then((users) => {
        this.users = users;
      })
      .catch((err) => console.log(err));
  },
  methods: {
    getAvatar(avatar) {
      return !!avatar ? avatar : defaultAvatar;
    },
    confirmUser(index) {
      confirmUser(this.users[index]).then((response) => {
        this.users[index] = response.data.user;
        this.users = { ...this.users };
      });
    },
    deleteUser(index) {
      const removeUser = this.users[index];
      deleteUser(removeUser).then((response) => {
        this.users = this.users.filter(
          (user) => user.email != removeUser.email
        );
      });
    },
  },
};
</script>

<style></style>
