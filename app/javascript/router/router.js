import VueRouter from "vue-router";
import Vue from "vue";
import Home from "../views/Home.vue";
import Login from "../views/Login.vue";
import SignUp from "../views/SingUp.vue";

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
];

const router = new VueRouter({
  mode: "history",
  routes,
});

export default router;
