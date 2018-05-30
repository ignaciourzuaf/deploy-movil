FactoryBot.define do
  factory :category do
    name { Faker::Lorem.unique.sentence }
    default_description { Faker::Lorem.sentence }
    association :type, factory: :type
    association :severity, factory: :severity
  end
end
