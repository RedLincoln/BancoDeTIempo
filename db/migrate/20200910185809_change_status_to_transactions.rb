class ChangeStatusToTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :status, :string, default: 'Negociación'
  end
end
