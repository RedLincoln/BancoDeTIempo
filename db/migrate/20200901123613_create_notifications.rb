class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.text :message
      t.string :target

      t.timestamps
    end
  end
end
