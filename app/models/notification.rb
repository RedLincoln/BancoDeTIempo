class Notification < ApplicationRecord
  validates :message, :target, presence: true

  belongs_to :user

  def as_json(*)
    super(:only => [:message, :target])
  end

end
