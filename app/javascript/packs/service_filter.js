import Vue from 'vue/dist/vue.esm'
import ServiceFilter from "../parts/ServiceFilter/ServiceFilter";
import { isView } from "vueonrails";
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
    if (!isView('services#index')) return;
    new Vue({
        el: '#service-filter',
        render: h => h(ServiceFilter)
    })
})