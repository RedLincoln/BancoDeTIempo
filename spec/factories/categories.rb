FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "name_#{n}" }
    supcategory { 'SUPCATEGORY' }
  end
end
