class Transaction < ApplicationRecord
  belongs_to :user, foreign_key: 'client_id'
  belongs_to :service
end
