class ChatRoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  def addMessage(message)
    update(last_message: message, message_not_read_count: message_not_read_count + 1)
  end

  def reset_message_count
    update(message_not_read_count: 0)
  end
end
