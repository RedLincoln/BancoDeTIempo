import store from "./store/store";

export const rules = {
  required: (value) => !!value || value === 0 || "Campo obligatorio",
  email: (value) =>
    /[a-z0-9]+@[a-z]+\.[a-z]{2,}/.test(value) || "Email incorrecto",
};

export const notice = (message) => {
  store.dispatch("flash/addFlash", {
    type: "notice",
    message,
  });
};

export const alert = (message) => {
  store.dispatch("flash/addFlash", {
    type: "alert",
    message,
  });
};
