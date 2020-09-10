class Message < ApplicationRecord
  belongs_to :service_petition, class_name: :Transaction
  belongs_to :author, class_name: :User

  validates :message , presence: true
end
