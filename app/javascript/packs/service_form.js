// Generated by Vue on Rails https://github.com/vueonrails/vueonrails
// Display this Vue component on Rails View by adding `require('./service_form')` to app/javascript/application.js
// Generate a component part by running command `rails generate vue something`

import Vue from 'vue'
import App from '@/service_form.vue'
import TurbolinksAdapter from 'vue-turbolinks'
import { isView } from "vueonrails";

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  if (isView('services#new') || isView('services#edit')){
    const service_form = new Vue({
      el: '#service_form',
      render: h => h(App)
    })
  }
})