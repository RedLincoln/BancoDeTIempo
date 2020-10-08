class AddScopeToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :scope, :string, default: ''
  end
end
