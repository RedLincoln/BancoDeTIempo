class Notification < ApplicationRecord
  validates :message, :target, presence: true

  belongs_to :user

  def as_json(*)
    super(:only => [:message, :target])
  end

  def created_ago
    seconds = (Time.now - created_at).to_i
    if seconds > 1.hour
      pluralize((seconds + 1)/1.hour, 'hora')
    elsif seconds > 1.minute
      pluralize((seconds + 1)/1.minute, 'minuto')
    else
      "#{seconds} segundos"
    end
  end

  private

  def pluralize(value, time_range)
    if value > 1
      "#{value} #{time_range}s"
    else
      "#{value} #{time_range}"
    end
  end
end
