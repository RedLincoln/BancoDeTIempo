class Service < ApplicationRecord
  validates :name, :description, presence: true
  validates :name, uniqueness: { scope: :user_id}

  belongs_to :user
  belongs_to :category

  def self.services_not_made_by(user)
    where.not(user: user)
  end

  def self.find_by_category_name(category_name = '')
    return all if category_name == '' || category_name == nil
    categories = Category.search_by_name(category_name).map(&:id)
    where(category: categories)
  end

  def self.amount(amount)
    Service.limit(amount)
  end
end
