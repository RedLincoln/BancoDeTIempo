class ChageRatingInRate < ActiveRecord::Migration[5.2]
  def change
    remove_column :rates, :rating, :integer
    add_column :rates, :rating, :decimal
  end
end
