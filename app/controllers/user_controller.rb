class UserController < ApplicationController

  def index
  end

  def services
    @services = current_user.services
  end

  def notifications
    respond_to do |format|
      format.json { render json: current_user.notifications.order(created_at: :desc).to_json}
    end
  end
end
