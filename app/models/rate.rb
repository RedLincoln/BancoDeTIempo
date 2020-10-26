class Rate < ApplicationRecord
  belongs_to :petition, foreign_key: 'transaction_id', class_name: 'Transaction'
  validates :rating, presence: true
end
