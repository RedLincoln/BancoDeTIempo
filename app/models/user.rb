class User < ApplicationRecord
  has_many :services
  has_many :transactions, foreign_key: 'client_id'
  has_many :notifications
  enum role: {standard: 'standard', admin: 'admin'}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  def have_transaction?(service)
    transactions.any? do |transaction|
      transaction.service.id == service.id
    end
  end

  def find_service(service_id)
    Service.find_by! id: service_id, user_id: id
  end
end
