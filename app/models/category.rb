class Category < ApplicationRecord
  validates :name, :supcategory, presence: true

  validates :name, uniqueness: { scope: :supcategory}

  def as_json(*)
    super(:only => [:id, :name, :supcategory])
  end

  def self.search_by_name(search_string)
    regex = Regexp.new(Regexp.escape(search_string), Regexp::IGNORECASE)
    Category.all.select do |category|
      category.name.delete(' ') =~ regex
    end
  end

  def self.grouped_by_supcategory
    hash = Hash.new{ |h,k| h[k]=[]}
    Category.all.each do |category|
      hash[category.supcategory] << category
    end
    hash
  end
end
