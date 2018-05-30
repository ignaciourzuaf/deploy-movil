FactoryBot.define do
  factory :type do
    name { Faker::Lorem.unique.word }
    has_severity { Faker::Boolean.boolean }
  end
end
