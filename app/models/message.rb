class Message < ApplicationRecord
  include Rails.application.routes.url_helpers

  after_commit :broadcast
  belongs_to :service_petition, class_name: :Transaction
  belongs_to :author, class_name: :User

  validates :message , presence: true

  private

  def broadcast
    user = service_petition.client == author ? service_petition.service.user : service_petition.client
    notification = user.notifications.build(
        message: 'Nuevo mensaje en ',
        target: service_petition.service.name,
        link: transaction_messages_path(service_petition.id))

    notification.save
    ActionCable.server.broadcast "notifications_#{user.id}", notification.to_json
  end

end
