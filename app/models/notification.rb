class Notification < ApplicationRecord
  validates :message, :target, presence: true

  belongs_to :user
end
