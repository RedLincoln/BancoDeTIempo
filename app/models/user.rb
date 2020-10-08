class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_many :services
  has_many :transactions_owner, through: :services, source: :transactions
  has_many :transactions_client, foreign_key: 'client_id', class_name: 'Transaction'
  has_many :notifications
  enum role: {standard: 'standard', admin: 'admin'}

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def transactions
    transactions_client.order(created_at: :desc) + transactions_owner.order(created_at: :desc)
  end

  def have_transaction?(service)
    have_transaction_helper(service, transactions)
  end

  def have_transaction_as_client?(service)
    have_transaction_helper(service, transactions_client)
  end

  def have_transaction_as_owner?(service)
    have_transaction_helper(service, transactions_owner)
  end

  def find_service(service_id)
    Service.find_by! id: service_id, user_id: id
  end

  def find_notification(notification_id)
    Notification.find_by! id:notification_id, user_id: id
  end

  private

  def have_transaction_helper(service, transactions)
    transactions.any? do |transaction|
      transaction.service.id == service.id
    end
  end
end
