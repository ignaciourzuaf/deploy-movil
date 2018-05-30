FactoryBot.define do
  factory :annotation do
    detail 'descripcion'
    is_additional_subject true
    creator_id 1
    group_id 1
    date '2018-03-01'
    is_group true
    subject_id 1
    association :category, factory: :category
  end
end
