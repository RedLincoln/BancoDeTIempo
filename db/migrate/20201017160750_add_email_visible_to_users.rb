class AddEmailVisibleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_visible, :boolean, default: true
  end
end
