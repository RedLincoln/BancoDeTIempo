import Vue from 'vue/dist/vue.esm'
import ServiceSearcher from "../parts/ServiceSercher/ServiceSearcher";
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
    new Vue({
        el: '#service-searcher',
        render: h => h(ServiceSearcher)
    })
})