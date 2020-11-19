class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :datetime
      t.text :addition_information
      t.references :service
      t.references :client, foreign_key: false
      t.string :status, default: 'Pendiente'

      t.timestamps
    end
    add_foreign_key :transactions, :users, column: :client_id
  end
end
