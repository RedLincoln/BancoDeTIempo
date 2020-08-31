require 'faker'

FactoryBot.define do
  factory :transaction do
    service
    client { create(:user) }
  end
end
