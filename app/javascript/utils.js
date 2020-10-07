export const rules = {
  required: (value) => !!value || "Campo obligatorio",
  email: (value) => /@/.test(value) || "Email incorrecto",
};
