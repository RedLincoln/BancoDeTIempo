require 'faker'

FactoryBot.define do
  factory :transaction do
    datetime { DateTime.now }
    duration { 2 }
    service
    client { create(:user) }
  end
end
