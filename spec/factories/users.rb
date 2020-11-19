FactoryBot.define do
  factory :user do
    name { 'George Lucas' }
    sequence(:email) { |n| "name#{n}@example#{n}.com" }
    password { 'password' }
    confirmed { true }

    factory :admin do
      role { 'admin' }
    end
  end
end