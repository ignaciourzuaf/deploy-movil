require 'rails_helper'

RSpec.describe Annotation, type: :model do
  describe 'validations' do
    # Create a subject
    # This is needed to prevent validate uniqueness from failing
    subject(:annotation) { create(:annotation) }

    it { should validate_presence_of(:student_id) }
    it { should validate_uniqueness_of(:student_id).scoped_to(annotation_id) }
  end

  describe 'associations' do
    it { should belong_to(:annotation) }
  end
end
