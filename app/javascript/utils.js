export const rules = {
  required: (value) => !!value || "Campo obligatorio",
  email: (value) =>
    /[a-z0-9]+@[a-z]+\.[a-z]{2,}/.test(value) || "Email incorrecto",
};
