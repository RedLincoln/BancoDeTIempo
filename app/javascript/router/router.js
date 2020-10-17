import VueRouter from "vue-router";
import Vue from "vue";
import store from "../store/store";
import Home from "../views/Home.vue";
import Login from "../views/Login.vue";
import SignUp from "../views/SingUp.vue";
import AdminUserManage from "../views/AdminUserManage.vue";
import Services from "../views/Services.vue";
import UserProfile from "../views/UserProfile.vue";
import Users from "../views/Users.vue";
import ServiceProfile from "../views/ServiceProfile.vue";
import NewService from "../views/NewService.vue";
import NewServicePetition from "../views/NewServicePetition.vue";
import Petitions from "../views/Petitions.vue";

import ServiceService from "../services/services";
import UserService from "../services/user";
import PetitionService from "../services/petitions";

const { getAll: getAllPetitions } = PetitionService;
const { getAll, getService, getCategories, getTags } = ServiceService;
const { getUser } = UserService;

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home",
    component: Home,
  },
  {
    path: "/services",
    name: "services",
    component: Services,
    props: true,
    beforeEnter(to, from, next) {
      getAll().then((services) => {
        to.params.services = services;
        next();
      });
    },
  },
  {
    path: "/services/petition/new",
    name: "new-service-petition",
    component: NewServicePetition,
    props: true,
    beforeEnter(to, from, next) {
      if (!!to.query.id) {
        getService(to.query.id).then((service) => {
          to.params.service = service;
          next();
        });
      } else {
        store.dispatch("flash/addFlash", {
          type: "alert",
          message: "Error en el servidor",
        });
        next({ name: "home" });
      }
    },
  },
  {
    path: "/services/new",
    name: "new-service",
    component: NewService,
    props: true,
    beforeEnter(to, from, next) {
      Promise.all([getCategories(), getTags()])
        .then(([categories, tags]) => {
          to.params.categories = categories;
          to.params.tags = tags;
          next();
        })
        .catch((err) => {
          store.dispatch("flash/addFlash", {
            type: "alert",
            message: "Error en el servidor",
          });
          next({ name: "home" });
        });
    },
  },
  {
    path: "/services/:id",
    name: "service-profile",
    component: ServiceProfile,
    props: true,
    beforeEnter(to, from, next) {
      getService(to.params.id)
        .then((service) => {
          to.params.service = service;
          getUser(service.user_id).then((user) => {
            to.params.user = user;
            next();
          });
        })
        .catch((err) => {
          store.dispatch("flash/addFlash", {
            type: "alert",
            message: "No se ha podido encontrar el servicio",
          });
          next({ name: "home" });
        });
    },
  },
  {
    path: "/petitions",
    name: "petitions",
    component: Petitions,
    props: true,
    beforeEnter(to, from, next) {
      getAllPetitions()
        .then((data) => {
          to.params.petitions = data.petitions;
          next();
        })
        .catch(() => next());
    },
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
    path: "/profile/:id",
    name: "user-profile",
    component: UserProfile,
    props: true,
  },
  {
    path: "/users",
    name: "users",
    component: Users,
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
