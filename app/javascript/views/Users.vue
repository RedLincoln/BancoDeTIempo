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
            <BaseSelect
              :items="roles"
              label="Filtrar por rol"
              item-text="es"
              @change="selectedRole = $event"
            />
          </v-col>
        </v-row>
      </div>
    </BaseCenter>
    <v-pagination v-model="page" :length="paginationLength"></v-pagination>
    <p class="text-center">{{ first }}-{{ last }} de {{ total }}</p>
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
    <v-pagination v-model="page" :length="paginationLength"></v-pagination>
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
      selectedRole: { es: "Todos los Usuarios", value: "" },
      roles: [
        { es: "Todos los Usuarios", value: "" },
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
    first() {
      return 1 + (this.page - 1) * this.perPage;
    },
    last() {
      return this.first + this.users.length - 1;
    },
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
