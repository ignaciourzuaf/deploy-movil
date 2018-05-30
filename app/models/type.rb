# Type model
class Type < ApplicationRecord
  has_many :categories, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
