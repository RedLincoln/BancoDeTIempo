FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:supcategory) { |n| "SUPCATEGORY_#{n}" }
  end
end
