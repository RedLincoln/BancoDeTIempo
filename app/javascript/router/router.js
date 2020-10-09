import VueRouter from "vue-router";
import Vue from "vue";
import store from "../store/store";
import Home from "../views/Home.vue";
import Login from "../views/Login.vue";
import SignUp from "../views/SingUp.vue";
import AdminUserManage from "../views/AdminUserManage.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home",
    component: Home,
  },
  {
    path: "/login",
    name: "login",
    component: Login,
  },
  {
    path: "/sign_up",
    name: "sign_up",
    component: SignUp,
  },
  {
    path: "/admin/users",
    name: "admin-users",
    component: AdminUserManage,
    beforeEnter: (to, from, next) => {
      if (
        store.state.session.loggedIn &&
        store.state.session.role === "admin"
      ) {
        next();
      } else {
        store.dispatch("flash/addFlash", {
          type: "alert",
          message: "Acceso denegado",
        });
        next({ name: "home " });
      }
    },
  },
];

const router = new VueRouter({
  mode: "history",
  routes,
});

export default router;
