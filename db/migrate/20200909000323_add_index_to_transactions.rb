class AddIndexToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_index :transactions, [:client_id, :service_id], unique: true
  end
end
