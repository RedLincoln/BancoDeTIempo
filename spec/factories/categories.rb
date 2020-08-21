require 'faker'

FactoryBot.define do
  factory :category do
    name { Faker::Types.rb_string }
    supcategory { 'SUPCATEGORY' }
  end
end
