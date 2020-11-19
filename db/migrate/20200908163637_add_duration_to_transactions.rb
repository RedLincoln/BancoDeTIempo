class AddDurationToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :duration, :integer
  end
end
