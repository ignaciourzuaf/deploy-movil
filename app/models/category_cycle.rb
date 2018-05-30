# Category cycle
class CategoryCycle < ApplicationRecord
  belongs_to :category
  belongs_to :cycle
end
