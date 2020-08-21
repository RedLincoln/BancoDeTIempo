require 'faker'

FactoryBot.define do
  factory :user do
    name { 'George Lucas' }
    email { Faker::Internet.unique.email }
    password { 'password' }

    factory :admin do
      role { 'admin' }
    end
  end
end