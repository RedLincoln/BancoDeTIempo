class Category < ApplicationRecord
  validates :name, :supcategory, presence: true

  validates :name, uniqueness: true
end
