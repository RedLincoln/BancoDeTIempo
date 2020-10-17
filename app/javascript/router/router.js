import VueRouter from "vue-router";
import Vue from "vue";
import store from "../store/store";
import Home from "../views/Home.vue";
import Login from "../views/Login.vue";
import SignUp from "../views/SingUp.vue";
import AdminUserManage from "../views/AdminUserManage.vue";
import ServicesOffer from "../views/ServicesOffer.vue";
import ServiceDemand from "../views/ServicesDemand.vue";
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
const {
  getOffers,
  getDemand,
  getService,
  getCategories,
  getTags,
} = ServiceService;
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
    component: ServicesOffer,
    props: true,
    beforeEnter(to, from, next) {
      store.dispatch("setLoading", true);
      getOffers().then((data) => {
        to.params.services = data.services;
        store.dispatch("setLoading", false);
        next();
      });
    },
  },
  {
    path: "/demand",
    name: "services-demand",
    component: ServiceDemand,
    props: true,
    beforeEnter(to, from, next) {
      store.dispatch("setLoading", true);
      getDemand().then((data) => {
        store.dispatch("setLoading", false);
        to.params.services = data.services;
        next();
      });
    },
  },
  {
    path: "/demand/new",
    name: "new-demand",
    component: NewService,
    props: true,
    beforeEnter(to, from, next) {
      store.dispatch("setLoading", true);
      Promise.all([getCategories(), getTags()])
        .then(([categories, tags]) => {
          to.params.categories = categories;
          to.params.tags = tags;
          to.params.offer = false;
          store.dispatch("setLoading", false);
          next();
        })
        .catch((err) => {
          store.dispatch("flash/addFlash", {
            type: "alert",
            message: "Error en el servidor",
          });
          store.dispatch("setLoading", false);
          next({ name: "home" });
        });
    },
  },
  {
    path: "/services/petition/new",
    name: "new-service-petition",
    component: NewServicePetition,
    props: true,
    beforeEnter(to, from, next) {
      store.dispatch("setLoading", true);
      if (!!to.query.id) {
        getService(to.query.id).then((service) => {
          to.params.service = service;
          store.dispatch("setLoading", false);
          next();
        });
      } else {
        store.dispatch("flash/addFlash", {
          type: "alert",
          message: "Error en el servidor",
        });
        store.dispatch("setLoading", false);
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
      store.dispatch("setLoading", true);
      Promise.all([getCategories(), getTags()])
        .then(([categories, tags]) => {
          to.params.categories = categories;
          to.params.tags = tags;
          store.dispatch("setLoading", false);
          next();
        })
        .catch((err) => {
          store.dispatch("flash/addFlash", {
            type: "alert",
            message: "Error en el servidor",
          });
          store.dispatch("setLoading", false);
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
      store.dispatch("setLoading", true);
      getService(to.params.id)
        .then((service) => {
          to.params.service = service;
          getUser(service.user_id).then((user) => {
            to.params.user = user;
            store.dispatch("setLoading", false);
            next();
          });
        })
        .catch((err) => {
          store.dispatch("flash/addFlash", {
            type: "alert",
            message: "No se ha podido encontrar el servicio",
          });
          store.dispatch("setLoading", false);
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
      store.dispatch("setLoading", true);
      getAllPetitions()
        .then((data) => {
          to.params.petitions = data.petitions;
          store.dispatch("setLoading", false);
          next();
        })
        .catch(() => {
          store.dispatch("setLoading", false);
          next();
        });
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
    beforeEnter(to, from, next) {
      store.dispatch("setLoading", true);
      getUser(to.params.id)
        .then((data) => {
          to.params.user = data.user;
          to.params.services = data.services;
          store.dispatch("setLoading", false);
          next();
        })
        .catch((err) => {
          store.dispatch("flash/addFlash", {
            type: "alert",
            message: "Acceso denegado",
          });
          store.dispatch("setLoading", false);
          next({ name: "home " });
        });
    },
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
