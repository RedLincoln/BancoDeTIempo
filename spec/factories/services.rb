FactoryBot.define do
  factory :service do
    sequence(:name) { |n| "name_#{n}"}
    description { "Casa" }
    category
    user
  end
end
