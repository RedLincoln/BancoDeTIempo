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
import EditService from "../views/EditService.vue";
import NewServicePetition from "../views/NewServicePetition.vue";
import EditServicePetition from "../views/EditServicePetition.vue";
import Petitions from "../views/Petitions.vue";

import ServiceService from "../services/services";
import PetitionService from "../services/petitions";
import { alert } from "../utils";

const { getPetition, getPetitions } = PetitionService;
const { getDemand, getService } = ServiceService;

Vue.use(VueRouter);

const fetchCategoriesAndTags = () => {
  store.dispatch("setLoading", true);
  store.dispatch("service/fetchTagsAndCategories").then(() => {
    store.dispatch("setLoading", false);
  });
};

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
    beforeEnter(to, from, next) {
      store.dispatch("services/fetchCategories").then(() => next());
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
      fetchCategoriesAndTags();
      to.params.offer = false;
      next();
    },
  },
  {
    path: "/service/petition/edit/:id",
    name: "edit-service-petition",
    component: EditServicePetition,
    props: true,
    beforeEnter(to, from, next) {
      store.dispatch("setLoading", true);
      getPetition(to.params.id).then((response) => {
        to.params.service = response.data.service;
        to.params.petition = response.data.petition;
        store.dispatch("setLoading", false);
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
    path: "/service/edit/:id",
    name: "service-edit",
    component: EditService,
    props: true,
    beforeEnter(to, from, next) {
      fetchCategoriesAndTags();
      getService(to.params.id).then((service) => {
        to.params.service = service;
        next();
      });
    },
  },
  {
    path: "/services/new",
    name: "new-service",
    component: NewService,
    props: true,
    beforeEnter(to, from, next) {
      fetchCategoriesAndTags();
      next();
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
          store.dispatch("setLoading", false);
          next();
        })
        .catch((err) => {
          alert("No se ha podido encontrar el servicio");
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
      store.dispatch("petitions/fetch", { q: "" }).then(() => next());
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
    beforeEnter: (to, from, next) => {
      store.dispatch("setLoading", true);
      next();
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
