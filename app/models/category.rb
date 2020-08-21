class Category < ApplicationRecord
  validates :name, :supcategory, presence: true
end
