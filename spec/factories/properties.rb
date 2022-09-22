FactoryBot.define do
  factory :property do
    name { Faker::Address.full_address }
  end
end
