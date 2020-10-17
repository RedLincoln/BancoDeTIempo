class Tag < ApplicationRecord
  has_and_belongs_to_many :services

  def self.build_or_get_tag_by_name(name)
    Tag.exists?(name: name) ? Tag.find_by(name: name) : Tag.new(name: name)
  end
end
