class Api::RegistrationController < ApplicationController

  def create
    @user = User.new(user_params)
    @user.password = 'placeholder_password'
    if @user.save
      Notification.create!(
          message: "Nuevo usuario pide desea crear una cuenta",
          scope: 'admin',
          target: user_params[:name],
          link: root_path)
      UserMailer.register_confirmation(@user).deliver
      render json: { message: 'Se ha enviado una notificación a un administrador, este se comunicará con usted' }
    else
      puts @user.errors.full_messages
      render json: { message: 'Error al crear usuario, contacte con un administrador'}
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :avatar, :information)
  end
end
