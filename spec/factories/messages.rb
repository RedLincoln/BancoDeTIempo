FactoryBot.define do
  factory :message do
    message { "MyText" }
    transaction { nil }
    author { nil }
  end
end
