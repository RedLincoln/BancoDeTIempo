export const rules = {
  required: (value) => !!value || "Campo obligatorio",
  email: (value) =>
    /[a-z]+@[a-z]+\.[a-z]{2,}/.test(value) || "Email incorrecto",
};
