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


import Vue from 'vue'
import ActionCable from 'actioncable'

Vue.prototype.$cable = ActionCable.createConsumer('/cable')
Vue.prototype.$updateNotificationPath = (id) => {
    return Routes.update_notification_path(id, { format: 'json' })
}

Vue.prototype.$servicesPath = Routes.services_path()
Vue.prototype.$userNotificationsPath = Routes.user_notifications_path({ format: 'json' })
Vue.prototype.$loginPath = Routes.new_user_session_path()
Vue.prototype.$signUpPath = Routes.new_user_registration_path()
Vue.prototype.$signOutPath = Routes.destroy_user_session_path({ format: 'json'})
Vue.prototype.$userServicesPath = Routes.user_services_path()
Vue.prototype.$createTransactionPath = Routes.transactions_path({ format: 'js'})
Vue.prototype.$userProfilePath = Routes.user_index_path()
Vue.prototype.$userAccountPath = Routes.user_account_path()
Vue.prototype.$getJsonCategoriesPath = Routes.categories_path({ format: 'json' })
Vue.prototype.$getCSRFToken = () => {
    return document.querySelector("meta[name=csrf-token]").getAttribute('content')
}

import './session_actions'
import './transaction_form'
import './service_filter'