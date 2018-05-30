FactoryBot.define do
  factory :annotated_student do
    student_id 1
    association :annotation, factory: :annotation
  end
end
