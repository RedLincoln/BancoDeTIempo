FactoryBot.define do
  factory :service do
    description { "Casa" }
    category
    user
    sequence(:name) do
      gen = "name_#{Random.rand(2000)}"
      while Service.where(name: gen).exists? do
        gen = "name_#{Random.rand(2000)}"
      end
      gen
    end
  end
end
