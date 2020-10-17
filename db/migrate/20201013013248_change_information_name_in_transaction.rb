class ChangeInformationNameInTransaction < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :addition_information, :text
    add_column :transactions, :additional_information, :text
  end
end
