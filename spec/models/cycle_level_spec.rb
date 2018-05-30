require 'rails_helper'

RSpec.describe CycleLevel, type: :model do
  describe 'validations' do
    # Create a subject
    # This is needed to prevent validate uniqueness from failing
    subject { CycleLevel.new }

    it { should validate_uniqueness_of(:group_level_id).scoped_to(:cycle_id) }
  end

  describe 'associations' do
    it { should belong_to(:cycle) }
  end
end
