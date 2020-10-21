json.(chat_room_user, :closed, :last_message, :message_not_read_count)
json.(chat_room_user.chat_room, :users, :name, :id)
unless chat_room_user.chat_room.messages.last.nil?
  json.last_chat_room_message do
    json.(chat_room_user.chat_room.messages.last, :message, :created_at, :updated_at )
    json.author do
      json.(chat_room_user.chat_room.messages.last.author, :id, :name)
    end
  end
else
  json.last_chat_room_message nil
end