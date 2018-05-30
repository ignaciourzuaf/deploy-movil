# Severity model
class Severity < ApplicationRecord
  has_many :categories, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
