export const setToken = (token) => {
  localStorage.setItem("jwt_token", token);
};

export const getToken = () => {
  localStorage.getItem("jwt_token");
};
