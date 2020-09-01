class NotificationsChannel < ActionCable::Channel::Base
  def subscribed
    stream_from "notifications_#{params[:user_id]}"
  end
end