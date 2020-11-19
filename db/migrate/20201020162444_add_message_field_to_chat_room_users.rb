class AddMessageFieldToChatRoomUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :chat_room_users, :last_message, :text
    add_column :chat_room_users, :message_not_read_count, :integer, default: 0
  end
end
