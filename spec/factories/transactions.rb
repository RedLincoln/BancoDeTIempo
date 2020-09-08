require 'faker'

FactoryBot.define do
  factory :transaction do
    datetime { '10/10/2020 10:00' }
    duration { 2 }
    service
    client { create(:user) }
  end
end
