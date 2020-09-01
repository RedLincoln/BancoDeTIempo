class Transaction < ApplicationRecord
  after_commit :broadcast
  belongs_to :client, class_name: :User
  belongs_to :service

  validate :service_owner_can_not_be_the_client

  def as_json(*)
    {
        service: service
    }
  end

  private

  def service_owner_can_not_be_the_client
    nil_checker = service.nil? || client.nil?
    if nil_checker || service.user == client
      errors.add(:client, 'client and service owner can not be the same')
    end
  end

  def broadcast
    data = {
        target: service.name,
        message: 'Se have pedido el servicio'
    }.to_json
    ActionCable.server.broadcast "notifications_#{service.user.id}", data
  end
end
