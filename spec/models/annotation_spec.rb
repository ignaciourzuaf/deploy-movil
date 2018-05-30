require 'rails_helper'

RSpec.describe Annotation, type: :model do
  describe 'validations' do
    let(:category) { create(:category) }

    # Create a subject
    # This is needed to prevent validate uniqueness from failing
    subject(:annotation) { create(:annotation) }

    it { should validate_presence_of(:detail) }
    it { should validate_presence_of(:creator_id) }
    it { should validate_inclusion_of(:is_group).in_array([true, false]) }
    it { should validate_presence_of(:subject_id) }
  end

  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:annotated_students).dependent(:destroy) }
  end
end
