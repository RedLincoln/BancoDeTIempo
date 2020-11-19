class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.references :transaction, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
