class Message < ApplicationRecord
  include Rails.application.routes.url_helpers
  after_commit :broadcast

  enum message_type: {text: 'text', petition_edit: 'petition_edit'}
  belongs_to :service_petition, class_name: :Transaction
  belongs_to :author, class_name: :User

  validates :message , presence: true

  private

  def on_service_petition_edit
    service_petition.service.user.notifications.build(
        message: 'Se ha editado un pedido de servicio ',
        target: service_petition.service.name,
        link: transaction_messages_path(service_petition.id))
  end

  def on_message_creation(user)
    user.notifications.build(
        message: 'Nuevo mensaje en ',
        target: service_petition.service.name,
        link: transaction_messages_path(service_petition.id))
  end

  def broadcast
    user = service_petition.client == author ? service_petition.service.user : service_petition.client

    notification = (petition_edit?) ? on_service_petition_edit : on_message_creation(user)
    notification.save

    ActionCable.server.broadcast "notifications_#{user.id}", notification.to_json
  end

end
