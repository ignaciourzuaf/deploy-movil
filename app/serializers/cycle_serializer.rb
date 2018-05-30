# Cycle serializer
class CycleSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :cycle_levels
  has_many :categories
end
