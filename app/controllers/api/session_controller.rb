class Api::SessionController < ApplicationController


  # POST /api/session
  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: { user_name: @user.name, token: token}
    else
      render json: { error: "Email o contraseña incorrecta"}, status: :bad_request
    end
  end

end
