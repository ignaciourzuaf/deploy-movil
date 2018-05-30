# Type serializer
class TypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :has_severity
end
