class AddTypeToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :message_type, :string, default: 'text'
  end
end
