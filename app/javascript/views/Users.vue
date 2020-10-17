<template>
  <v-container>
    <v-pagination v-model="page" :length="paginationLength"></v-pagination>
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
import { mapState, mapActions } from "vuex";
import UserCard from "../components/UserCard";

export default {
  components: {
    UserCard,
  },
  data() {
    return {
      page: 1,
    };
  },
  watch: {
    page(val) {
      this.fetchUsers(val);
    },
  },
  computed: {
    paginationLength() {
      return Math.ceil(this.total / this.perPage);
    },
    ...mapState("users", ["users", "total", "perPage"]),
  },
  created() {
    this.fetchUsers(this.page);
  },
  methods: {
    fetchUsers(page) {
      this.$store.dispatch("users/fetch", page - 1);
    },
  },
};
</script>

<style></style>
