import Vue from 'vue/dist/vue.esm'
import ServiceSearcher from "../parts/ServiceSercher/ServiceSearcher";

document.addEventListener('turbolinks:load', () => {
    new Vue({
        el: '#service-searcher',
        render: h => h(ServiceSearcher)
    })
})