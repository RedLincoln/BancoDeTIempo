class Message < ApplicationRecord
  include Rails.application.routes.url_helpers
  after_commit :broadcast

  enum message_type: {text: 'text', petition_edit: 'petition_edit'}
  belongs_to :chat_room
  belongs_to :author, class_name: :User

  validates :message , presence: true

  def as_json(*)
    super().tap do |hash|
      hash[:author] = author
    end
  end

  private

  def broadcast
    ActionCable.server.broadcast "chat_room_#{chat_room.id}", message: self
  end

end
