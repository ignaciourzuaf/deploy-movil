# Annotation serializer
class AnnotationSerializer < ActiveModel::Serializer
  attributes :id, :detail,
             :creator_id, :date,
             :group_id, :is_group,
             :subject_id, :is_additional_subject
  belongs_to :category
  has_many :annotated_students
end
