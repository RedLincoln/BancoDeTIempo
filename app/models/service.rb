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

  def self.default_page_size
    5
  end

  def self.page_count
    1 + count / default_page_size
  end

  def self.pagination(page: 1)
    page = 1 if page == nil
    return none if page <= 0
    amount(limit: default_page_size, offset: (page-1) * default_page_size)
  end

  def self.amount(limit: Service.count, offset: 0)
    limit(limit).offset(offset)
  end
end
