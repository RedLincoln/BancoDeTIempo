class Transaction < ApplicationRecord
  after_commit :broadcast
  enum status: {negotiating: 'Negociación', accepted: 'Aceptada', canceled: 'Cancelada'}
  validates :datetime, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0, less_than: 24}
  validates :client, uniqueness: { scope: :service}
  belongs_to :client, class_name: :User
  belongs_to :service


  validate :service_owner_can_not_be_the_client

  def as_json(*)
    {
        service: service
    }
  end

  def duration_range
    start = datetime.strftime("%H:%M")
    finalDatetime = datetime + 2.hour
    finish = finalDatetime.strftime("%H:%M")
    "#{start}-#{finish}"
  end

  def date_format
    datetime.strftime("%d/%m/%Y")
  end

  private

  def service_owner_can_not_be_the_client
    nil_checker = service.nil? || client.nil?
    if nil_checker || service.user == client
      errors.add(:client, 'client and service owner can not be the same')
    end
  end

  def broadcast
    notification = service.user.notifications.build(message: 'Se have pedido el servicio ', target: service.name)
    notification.save
    ActionCable.server.broadcast "notifications_#{service.user.id}", notification.to_json
  end
end
