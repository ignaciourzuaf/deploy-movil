# subjects in our database
class AdditionalSubject < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  attribute :is_additional_subject, :boolean, default: true
end
