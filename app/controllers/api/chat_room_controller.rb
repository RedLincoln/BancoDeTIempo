class Api::ChatRoomController < ApplicationController

  def index
    if logged_in?
      render json: { chat_rooms: @user.chat_rooms }
    else
      render json: { message: 'Unauthorized'}, status: :unprocessable_entity
    end
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
end
