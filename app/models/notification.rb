class Notification < ApplicationRecord
  validates :message, :target, presence: true

  belongs_to :user

  def as_json(*)
    super(:only => [:message, :target, :seen]).tap do |hash|
      hash[:time_ago] = "hace #{created_ago}"
    end
  end

  def created_ago
    seconds = (Time.now - created_at).to_i
    corrected_seconds = seconds + 1
    if corrected_seconds > 1.day
      pluralize(corrected_seconds/1.day, 'dia')
    elsif corrected_seconds > 1.hour
      pluralize(corrected_seconds/1.hour, 'hora')
    elsif corrected_seconds > 1.minute
      pluralize(corrected_seconds/1.minute, 'minuto')
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
