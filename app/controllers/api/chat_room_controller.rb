class Api::ChatRoomController < ApplicationController

  def index
    login_guard
  end

  def show
    login_guard
    @chat_room_user = ChatRoomUser.find_by!(chat_room: ChatRoom.find(params[:id]), user: @user)
  end

  def create_message
    if logged_in?
      chat_room = ChatRoom.find(params[:id])
      message = Message.new(author: @user, chat_room: chat_room, message: params[:message])
      if message.save
        render json: { message: 'Mensaje enviado', status: true }
      else
        puts message.errors.full_messages
      end
    end
  end

  def get_messages
    if logged_in?
      render json: { messages: ChatRoom.find(params[:id]).messages }
    else
      render json: { message: 'Unauthorized'}, status: :unprocessable_entity
    end
  end

  def reset_count
    login_guard
    begin
      ChatRoomUser.find_by!(chat_room_id: params[:id], user_id: @user.id).reset_message_count
    rescue ActiveRecord::RecordNotFound
      put "ERROR"
    end
  end
end
