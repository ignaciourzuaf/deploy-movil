# Annotated student serializer
class AnnotatedStudentSerializer < ActiveModel::Serializer
  attributes :id, :student_id, :annotation_id
end
