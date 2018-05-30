# CycleLevel model
# N-N relation Cycle (our DB) and group_level (papinotas DB)
class CycleLevel < ApplicationRecord
  belongs_to :cycle, inverse_of: :cycle_levels
  validates :group_level_id, presence: true, uniqueness: { scope: :cycle_id }
  validates_presence_of :cycle
end
