json.chat_rooms do
  json.array! @user.chat_room_users.sort_by(&:updated_at).reverse do |chat_room_user|
    json.partial! 'api/chat_room/chat_room', chat_room_user: chat_room_user
  end
end