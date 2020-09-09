class AddBalanceToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :balance, :integer, default: 5
  end
end
