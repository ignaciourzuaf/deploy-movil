FactoryBot.define do
  factory :severity do
    name { Faker::Lorem.unique.word }
  end
end
