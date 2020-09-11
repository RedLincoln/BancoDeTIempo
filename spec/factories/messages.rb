FactoryBot.define do
  factory :message do
    message { "MyText" }
    service_petition { nil }
    author { nil }
  end
end
