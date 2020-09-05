class AddUniqueIndexToCategory < ActiveRecord::Migration[5.2]
  def change
    add_index :categories, [:name, :supcategory], unique: true
  end
end
