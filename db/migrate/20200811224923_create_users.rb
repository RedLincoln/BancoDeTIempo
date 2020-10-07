# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.text   :introduction
      t.string :picture
      t.string :password_digest
      t.string :email

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
  end
end
