class UserMailer < ApplicationMailer
  default :from => "tft-bdt@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.register_confirmation.subject
  #
  def register_confirmation(user)
    @greeting = "Hi"

    mail( to: "#{user.name} <#{user.email}>", :subject => "Registro en Banco de Tiempo")
  end
end
