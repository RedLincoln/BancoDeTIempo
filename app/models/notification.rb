class Notification < ApplicationRecord
  validates :message, :target, presence: true

  belongs_to :user

  def as_json(*)
    super(:only => [:message, :target])
  end

  def created_ago
    seconds = (Time.now - created_at).to_i
    "#{seconds} segundos"
  end
end
