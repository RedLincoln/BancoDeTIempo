class AddChangesMadeToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :changes_made, :jsonb, null: false, default: '{}'
  end
end
