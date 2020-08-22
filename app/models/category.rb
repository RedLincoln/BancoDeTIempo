class Category < ApplicationRecord
  validates :name, :supcategory, presence: true

  validates :name, uniqueness: true

  def self.grouped_by_supcategory
    hash = Hash.new{ |h,k| h[k]=[]}
    Category.all.each do |category|
      hash[category.supcategory] << category
    end
    hash
  end
end
