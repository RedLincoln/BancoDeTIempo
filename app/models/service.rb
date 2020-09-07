class Service < ApplicationRecord
  @@page_size = 10

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

  def self.find_by_category_supcategory(supcategory = '')
    return all if supcategory == '' || supcategory == nil
    categories = Category.search_by_supcategory(supcategory).map(&:id)
    where(category: categories)
  end

  def self.set_default_page_size page_size
    @@page_size = page_size
  end

  def self.page_count
    return 1 if count == 0
    (count.to_f / @@page_size).ceil
  end

  def self.pagination(page: 1)
    page = 1 if page == nil || page == 0
    return none if page < 0
    amount(limit: @@page_size, offset: (page-1) * @@page_size)
  end

  def self.amount(limit: Service.count, offset: 0)
    limit(limit).offset(offset)
  end
end
