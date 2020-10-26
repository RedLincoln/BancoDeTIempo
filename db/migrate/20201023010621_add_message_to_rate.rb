class AddMessageToRate < ActiveRecord::Migration[5.2]
  def change
    add_column :rates, :message, :text
  end
end
