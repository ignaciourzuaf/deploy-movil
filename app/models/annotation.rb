# class of anotations
class Annotation < ApplicationRecord
  belongs_to :category, required: true
  has_many :annotated_students, dependent: :destroy,
                                autosave: true,
                                inverse_of: :annotation
  validates_presence_of :subject_id, :group_id, :creator_id
  validates_inclusion_of :is_group, :is_additional_subject, in: [true, false]
  validates :detail, presence: true, allow_blank: false

  accepts_nested_attributes_for :annotated_students,
                                allow_destroy: true
  validates_associated :annotated_students
  validate :validate_length

  def validate_length
    errors.add(:annotated_students, 'Must include students') \
     if annotated_students.nil?
    errors.add(:annotated_students, 'Must include students') \
     if annotated_students.size.zero? && !is_group
  end
end
