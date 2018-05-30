FactoryBot.define do
  factory :additional_subject do
    name { Faker::Lorem.unique.sentence }
  end
end
