class Api::Admin::UsersController < ApplicationController
  before_action :authorize_admin, only: [:confirm, :delete]

  def index
    @users = User.limit(params[:limit]).offset(params[:offset])
  end

  def confirm
    user = User.find_by(email: params[:email])
    user.update(confirmed: true)
    render json: { user: user }
  end

  def delete
    user = User.find_by(email: params[:email])
    user.destroy
    render json: { message: "Usuario #{user.name} eliminado" }
  end

  private

  def authorize_admin
    if !(logged_in? && @user.role == 'admin')
      render json: { message: 'Recurso denegado'}, status: :unprocessable_entity
    end
  end
end
