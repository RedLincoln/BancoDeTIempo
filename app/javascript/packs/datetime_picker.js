import Vue from 'vue/dist/vue.esm'
import App from '@/DatetimePicker/DatetimePicker.vue'
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
    new Vue({
        el : '#datetime-picker',
        render: h => h(App),
    })
});