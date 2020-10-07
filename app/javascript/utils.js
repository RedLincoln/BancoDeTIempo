export const rules = {
  required: (value) => !!value || "Campo obligatorio",
  email: (value) => /[a-z]{1}[a-z0-9]*@/.test(value) || "Email incorrecto",
};
