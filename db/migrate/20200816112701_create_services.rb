class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.references :user

      t.timestamps
    end
  end
end
