class CreateTagsAndServices < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :services_tags do |t|
      t.belongs_to :tag
      t.belongs_to :service
    end
  end
end
