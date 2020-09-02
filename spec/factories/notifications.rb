FactoryBot.define do
  factory :notification do
    message { 'message '}
    target { 'target' }
    user
  end
end
