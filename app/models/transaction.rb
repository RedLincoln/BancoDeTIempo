class Transaction < ApplicationRecord
  belongs_to :client, class_name: :User
  belongs_to :service

  validate :service_owner_can_not_be_the_client

  private

  def service_owner_can_not_be_the_client
    nil_checker = service.nil? && client.nil?
    if nil_checker || service.user == client
      errors.add(:client, 'client and service owner can not be the same')
    end
  end
end
