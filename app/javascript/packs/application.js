/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Vue from "vue";
import vuetify from "../plugins/vuetify";
import store from "../store/store";
import ActionCableVue from "actioncable-vue";

import router from "../router/router";
import App from "../App.vue";
import Logo from "../components/Logo.vue";
import Alert from "../components/Alert.vue";
import Notice from "../components/Notice.vue";
import Avatar from "../components/Avatar.vue";

Vue.component("Logo", Logo);
Vue.component("Alert", Alert);
Vue.component("Notice", Notice);
Vue.component("Avatar", Avatar);

Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: "error",
  connectionUrl: "ws://localhost:3000/cable",
  connectImmediately: true,
});

store.dispatch("session/logInWithToken");

document.addEventListener("DOMContentLoaded", () => {
  new Vue({
    router,
    store,
    vuetify,
    render: (h) => h(App),
  }).$mount("#app");
});
