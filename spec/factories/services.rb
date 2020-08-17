FactoryBot.define do
  factory :service do
    name { "MyString" }
    description { "MyText" }
    user
  end
end
