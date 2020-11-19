class RenameIntroductionToInformation < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :introduction, :text
    add_column :users, :information, :text
  end
end
