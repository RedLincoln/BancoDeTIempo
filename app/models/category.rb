class Category < ApplicationRecord
  validates :name, :supcategory, presence: true

  validates :name, uniqueness: true

  def self.grouped_by_category

  end
end
