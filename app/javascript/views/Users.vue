<template>
  <v-container>
    <BaseCenter>
      <div>
        <BaseSearchField
          placeholder="Buscar Usuario"
          v-model="search"
          @search="fetchUsers"
        />
        <v-row>
          <v-col>
            <v-subheader>Filtrar por rol</v-subheader>
          </v-col>
          <v-col>
            <v-select
              :items="roles"
              solo
              label="Filtrar por rol"
              v-model="selectedRole"
              item-text="es"
              item-value="value"
              return-object
            ></v-select>
          </v-col>
        </v-row>
      </div>
    </BaseCenter>
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
      selectedRole: { es: "Todos", value: "" },
      roles: [
        { es: "Todos", value: "" },
        { es: "Usuario", value: "standard" },
        { es: "Administrador", value: "admin" },
      ],
      search: "",
      page: 1,
    };
  },
  watch: {
    page(val) {
      this.fetchUsers();
    },
    selectedRole(val) {
      this.fetchUsers();
    },
  },
  computed: {
    paginationLength() {
      return Math.ceil(this.total / this.perPage);
    },
    ...mapState("users", ["users", "total", "perPage"]),
  },
  created() {
    this.fetchUsers();
  },
  methods: {
    fetchUsers() {
      this.$store.dispatch("users/fetch", {
        page: this.page - 1,
        search_string: this.search,
        role: this.selectedRole.value,
      });
    },
  },
};
</script>

<style></style>
