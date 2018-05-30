# Category model
class Category < ApplicationRecord
  belongs_to :severity, optional: true
  belongs_to :type

  has_many :category_cycles
  has_many :cycles, through: :category_cycles
  has_many :annotations, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :default_description, presence: true
  validate :severity?

  def severity?
    return errors.add(:type, 'can`t be blank') \
        if type.nil?
    errors.add(:severity, 'can`t be blank if type has severity') \
        if severity.nil? && type.has_severity
  end
end
