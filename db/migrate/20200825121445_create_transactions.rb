class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :datetime
      t.text :addition_information
      t.references :service
      t.references :client, index: true, foreign_key: {to_table: :user}
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
