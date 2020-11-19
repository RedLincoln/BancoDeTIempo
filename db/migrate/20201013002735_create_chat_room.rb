class CreateChatRoom < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|

      t.timestamps null: false
    end
  end
end
