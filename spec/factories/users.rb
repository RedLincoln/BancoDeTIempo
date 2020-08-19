require 'faker'

FactoryBot.define do
  factory :user do
    name { 'George Lucas' }
    email { Faker::Internet.email }
    password { 'password' }
  end
end