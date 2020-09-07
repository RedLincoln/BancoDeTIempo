FactoryBot.define do
  factory :user do
    name { 'George Lucas' }
    sequence(:email) { |n| "name#{n}@example#{n}.com" }
    password { 'password' }

    factory :admin do
      role { 'admin' }
    end
  end
end