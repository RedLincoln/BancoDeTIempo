class Api::SessionController < ApplicationController


  # POST /api/session
  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      success_handler
    else
      render json: { error: "Email o contraseña incorrecta"}, status: :bad_request
    end
  end

  def refresh
    if logged_in?
      success_handler
    end
  end

  private

  def success_handler
    if (@user.confirmed?)
      token = encode_token({user_id: @user.id})
      render json: { user: @user, token: token}
    else
      render json: { error: "El usuario aún no esta confirmado"}, status: :bad_request
    end
  end

end
