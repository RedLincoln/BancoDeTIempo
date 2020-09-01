class Notification < ApplicationRecord
  validates :message, :target, presence: true
end
