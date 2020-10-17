class ChatRoom < ApplicationRecord
  has_many :chat_room_users
  has_many :messages
  has_many :users, through: :chat_room_users

  def as_json(*)
    super(only: [:id, :name]).tap do |hash|
      hash[:users] = users
    end
  end
end
