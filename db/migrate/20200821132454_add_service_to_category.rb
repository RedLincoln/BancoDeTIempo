class AddServiceToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :service, :reference
  end
end
