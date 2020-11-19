class AddTelephoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :telephone, :string
    add_column :users, :telephone_visible, :boolean, default: true
  end
end
