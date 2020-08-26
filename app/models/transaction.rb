class Transaction < ApplicationRecord
  belongs_to :client, class_name: :User
  belongs_to :service
end
