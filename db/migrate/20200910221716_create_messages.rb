class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :message
      t.references :transaction, foreign_key: true
      t.references :author, foreign_key: false

      t.timestamps
    end
    add_foreign_key :messages, :users, column: :author_id
  end
end
