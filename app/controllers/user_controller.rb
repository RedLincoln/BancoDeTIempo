class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    @transaction = current_user.transactions
  end

  def services
    @services = current_user.services
  end

  def notifications
    respond_to do |format|
      format.json { render json: current_user.notifications.to_json}
    end
  end
end
