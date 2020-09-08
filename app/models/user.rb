class User < ApplicationRecord
  has_many :services
  has_many :transactions_owner, through: :services, source: :transactions
  has_many :transactions_client, foreign_key: 'client_id', class_name: 'Transaction'
  has_many :notifications
  enum role: {standard: 'standard', admin: 'admin'}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  def transactions
    transactions_client + transactions_owner
  end

  def have_transaction?(service)
    transactions.any? do |transaction|
      transaction.service.id == service.id
    end
  end

  def have_transaction_as_client?(service)
    transactions_client.any? do |transaction|
      transaction.service.id == service.id
    end
  end

  def have_transaction_as_owner?(service)
    transactions_client.any? do |transaction|
      transaction.service.id == service.id
    end
  end

  def find_service(service_id)
    Service.find_by! id: service_id, user_id: id
  end

  def find_notification(notification_id)
    Notification.find_by! id:notification_id, user_id: id
  end
end
