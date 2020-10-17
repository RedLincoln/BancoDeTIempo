class Api::UserController < ApplicationController

  def show
    user = User.find(params[:id])
    render json: { user: user }
  end

  def notifications
    if logged_in?
      render json: { notifications: @user.notifications.order(created_at: :desc) }
    end
  end

  def seen_notification
    if logged_in?
      Notification.find(params[:id]).update(seen: true)
      render json: { message: 'Notificación vista' }
    end
  end

end
