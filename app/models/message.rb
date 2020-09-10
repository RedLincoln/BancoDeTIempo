class Message < ApplicationRecord
  belongs_to :service_petition, class_name: :Transaction
  belongs_to :author

  validates :message , presence: true
end
