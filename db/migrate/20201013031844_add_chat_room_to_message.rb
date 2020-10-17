class AddChatRoomToMessage < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :service_petition_id
    add_reference :messages, :chat_room, foreign_key: true
  end
end
