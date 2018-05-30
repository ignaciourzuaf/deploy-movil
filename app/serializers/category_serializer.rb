# Category serializer
class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :default_description
  belongs_to :type
  belongs_to :severity
  has_many :cycles
end
