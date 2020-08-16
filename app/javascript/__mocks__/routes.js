module.exports =  {
    new_user_session_path: () => '/users/sign_in',
    destroy_user_session_path: () => '/users/sign_out',
    new_user_registration_path: () => '/users/sign_up',
    service_path: (id) => `/services/${id}`,
    services_path: () => '/services'
};