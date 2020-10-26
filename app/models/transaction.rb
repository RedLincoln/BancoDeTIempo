class Transaction < ApplicationRecord
  after_create :broadcast_create
  after_update :broadcast_update
  before_update :clone_record

  enum status: {negotiating: 'Negociación', accepted: 'Aceptada', canceled: 'Cancelada', done: 'Realizada', valued: 'Valorado'}
  validates :datetime, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0, less_than: 24}
  validates :client, uniqueness: { scope: :service}
  belongs_to :client, class_name: :User
  belongs_to :service

  has_one :client_rate, foreign_key: 'client_rate_id', class_name: 'Rate'
  has_one :owner_rate, foreign_key: 'owner_rate_id', class_name: 'Rate'

  validate :service_owner_can_not_be_the_client


  def duration_range
    start = datetime.strftime("%H:%M")
    finalDatetime = datetime + duration.hour
    finish = finalDatetime.strftime("%H:%M")
    "#{start}-#{finish}"
  end

  def date_format
    datetime.strftime("%d/%m/%Y")
  end

  private

  def diff_active_record(record_a, record_b)
    (record_a.attributes.to_a - record_b.attributes.to_a).map(&:first)
  end

  def clone_record
    @oldTransaction = Transaction.find(id).clone
  end

  def service_owner_can_not_be_the_client
    nil_checker = service.nil? || client.nil?
    if nil_checker || service.user == client
      errors.add(:client, 'client and service owner can not be the same')
    end
  end

  def send_status_change_notification
    new_status = read_attribute_before_type_cast(:status)
    service.user.notifications.create(
        message: "El estado ha cambiado a #{new_status} ",
        target: service.name)
    client.notifications.create(
        message: "El estado ha cambiado a #{new_status} ",
        target: service.name)
  end

  def broadcast_create
    chat_room = ChatRoom.new(name: service.name)
    chat_room.users << service.user
    chat_room.users << client
    chat_room.save

    service.user.notifications.create(
        message: 'Se ha pedido el servicio ',
        target: service.name)
  end

  def broadcast_update
    fields_changed = diff_active_record(@oldTransaction ,self)
    if (fields_changed.include? "status")
      send_status_change_notification
    end
  end
end
