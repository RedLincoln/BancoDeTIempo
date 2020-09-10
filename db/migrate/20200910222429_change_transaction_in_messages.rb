class ChangeTransactionInMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :transaction_id
    add_reference :messages, :service_petition, foreign_key: false
    add_foreign_key :messages, :transactions, column: :service_petition_id
  end
end
