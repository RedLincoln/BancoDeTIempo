class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_secure_password
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  has_one_attached :avatar
  has_many :services
  has_many :transactions_owner, through: :services, source: :transactions
  has_many :transactions_client, foreign_key: 'client_id', class_name: 'Transaction'
  has_many :notifications
  enum role: {standard: 'standard', admin: 'admin'}

  validates :email, presence: { message: "El campo email es obligatorio"}, uniqueness: { message: "El usuario ya existe"}
  validates :name, presence: { message: "El campo name es obligatorio"}

  def as_json(*)
    super(only: [:name, :confirmed, :email, :blocked, :role, :information, :id, :balance]).tap do |hash|
      hash[:avatar] = avatar.attached? ?
                          rails_blob_path(avatar, disposition: "attachment", only_path: true) :
                          nil
      hash[:services] = services
    end
  end

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

  def confirmed?
    confirmed
  end

  private

  def have_transaction_helper(service, transactions)
    transactions.any? do |transaction|
      transaction.service.id == service.id
    end
  end
end
