# join table between annotation and student
class AnnotatedStudent < ApplicationRecord
  belongs_to :annotation, inverse_of: :annotated_students
  validates :student_id, presence: true, uniqueness: { scope: :annotation_id }
  validates_presence_of :annotation
end
