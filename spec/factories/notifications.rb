FactoryBot.define do
  factory :notification do
    message { 'message '}
    sequence(:target) { |n| "target#{n}" }
    user
  end
end
