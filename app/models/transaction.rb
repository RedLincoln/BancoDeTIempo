class Transaction < ApplicationRecord
  include Rails.application.routes.url_helpers

  after_create :broadcast_create
  after_update :broadcast_update
  before_update :clone_record
  enum status: {negotiating: 'Negociación', accepted: 'Aceptada', canceled: 'Cancelada', done: 'Realizada'}
  validates :datetime, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0, less_than: 24}
  validates :client, uniqueness: { scope: :service}
  belongs_to :client, class_name: :User
  belongs_to :service

  validate :service_owner_can_not_be_the_client

  def done?
    done! if accepted? && datetime < DateTime.now
    super
  end

  def canceled?
    canceled! if negotiating? && datetime < DateTime.now
    super
  end

  def as_json(*)
    super(only: [:addition_information, :duration]).tap do |hash|
      hash[:service] = service
      hash[:datetime] = datetime.to_i * 1000
    end
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

  def self.check_datetime
    all.each do |transaction|
      if transaction.accepted? && transaction.datetime > DateTime.now
        find(transaction.id).done!
      end
    end
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
    notification_owner = service.user.notifications.create(
        message: "El estado ha cambiado a #{new_status} ",
        target: service.name,
        link: transaction_messages_path(id))
    notification_client = client.notifications.create(
        message: "El estado ha cambiado a #{new_status} ",
        target: service.name,
        link: transaction_messages_path(id))
    broadcast notification_owner
    broadcast notification_client
  end

  def broadcast_create
    notification = service.user.notifications.build(
        message: 'Se have pedido el servicio ',
        target: service.name,
        link: transaction_messages_path(id))
    notification.save
    broadcast notification
  end

  def broadcast_update
    fields_changed = diff_active_record(@oldTransaction ,self)
    if (fields_changed.include? "status")
      send_status_change_notification
    else
      Message.create(service_petition: self, author: client,
                     message_type: :petition_edit, message: 'Se ha editado el pedido'
      )
    end
  end


  def broadcast(notification)
    ActionCable.server.broadcast "notifications_#{service.user.id}", notification.to_json
  end
end
