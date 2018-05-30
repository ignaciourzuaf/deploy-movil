FactoryBot.define do
  factory :cycle do
    name { Faker::Lorem.unique.word }
  end
end
