# Cycle model
class Cycle < ApplicationRecord
  has_many :cycle_levels, dependent: :destroy,
                          autosave: true,
                          inverse_of: :cycle
  has_many :category_cycles
  has_many :categories, through: :category_cycles

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  accepts_nested_attributes_for :cycle_levels,
                                allow_destroy: true
  validates_associated :cycle_levels
end
