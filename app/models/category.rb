class Category < ApplicationRecord
  has_many :services
  validates :name, :supcategory, presence: true

  validates :name, uniqueness: { scope: :supcategory}

  def as_json(*)
    super(:only => [:id, :name, :supcategory])
  end

  def self.search_by_name(search_string)
    search_by_field(search_string, 'name')
  end

  def self.search_by_supcategory(search_string)
    search_by_field(search_string, 'supcategory')
  end

  def self.grouped_by_supcategory
    hash = Hash.new{ |h,k| h[k]=[]}
    Category.all.each do |category|
      hash[category.supcategory] << category
    end
    hash
  end

  private

  def self.search_by_field(search_string, field)
    regex = Regexp.new(Regexp.escape(search_string.delete(' ')), Regexp::IGNORECASE)
    Category.all.select do |category|
      category.send(field).delete(' ') =~ regex
    end
  end
end
