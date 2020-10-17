<template>
  <v-container>
    <v-row>
      <v-col cols="6" v-for="(user, index) in users" :key="index">
        <UserCard
          :avatar="user.avatar"
          :name="user.name"
          :information="user.information"
          :rating="!!user.rating ? user.rating : undefined"
          :id="user.id"
          :role="user.role"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import UsersService from "../services/user";
import UserCard from "../components/UserCard";

const { getUsers } = UsersService;

export default {
  components: {
    UserCard,
  },
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
};
</script>

<style></style>
