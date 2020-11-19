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
    user = chat_room.users.select { |user| user.id != author.id}[0]
    ChatRoomUser.find_by!(chat_room: chat_room, user: user).addMessage(message)
    ActionCable.server.broadcast "chat_room_#{chat_room.id}", message: self
    chat_room.users.each do |user|
      ActionCable.server.broadcast(
          "user_chat_#{user.id}",
          action: 'update',
          chat_room_id: chat_room.id)
    end
  end

end
