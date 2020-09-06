import Vue from 'vue/dist/vue.esm'
import App from "../parts/ServiceFilter/ServiceFilter";
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
    new Vue({
        el: '#testing-filter',
        render: h => h(App)
    })
})