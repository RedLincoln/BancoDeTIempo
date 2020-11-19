class AddingRatingToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :client_rate, foreign_key: { to_table: 'rates' }
    add_reference :transactions, :owner_rate, foreign_key: { to_table: 'rates' }
  end
end
