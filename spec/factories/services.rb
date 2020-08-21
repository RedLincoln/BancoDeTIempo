require 'faker'

FactoryBot.define do
  factory :service do
    name { Faker::Name.unique.name }
    description { "Casa" }
    category
    user
  end
end
