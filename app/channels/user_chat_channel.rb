class UserChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_chat_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
