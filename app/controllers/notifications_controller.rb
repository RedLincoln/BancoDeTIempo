class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
  end

  private

  def notifications_params
    params.require(:notification).permit(:seen)
  end
end
