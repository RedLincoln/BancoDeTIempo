class ChangeDatetimeInTransaction < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :datetime, :string
    add_column :transactions, :datetime, :datetime
  end
end
