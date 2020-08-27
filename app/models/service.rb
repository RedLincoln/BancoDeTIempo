class Service < ApplicationRecord
  validates :name, :description, presence: true
  validates :name, uniqueness: { scope: :user_id}

  belongs_to :user
  belongs_to :category

  def self.services_not_made_by(user)
    where.not(user: user)
  end
end
