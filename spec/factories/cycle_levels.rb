FactoryBot.define do
  factory :cycle_level do
    association :cycle, factory: :cycle
    group_level_id 1
  end
end
