json.chat do
  json.partial! 'api/chat_room/chat_room', chat_room_user: @chat_room_user
end
