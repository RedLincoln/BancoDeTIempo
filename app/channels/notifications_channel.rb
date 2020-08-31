class NotificationsChannel < ActionCable::Channel::Base
  def subscribed
    puts "subscribed"
    stream_from "notificaitons_#{params[:user_id]}"
  end
end