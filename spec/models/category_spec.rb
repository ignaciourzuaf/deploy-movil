require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    let(:type) { create(:type) }

    # Create a subject
    # This is needed to prevent validate uniqueness from failing
    subject(:category) { create(:category) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:default_description) }
  end

  describe 'associations' do
    it { should belong_to(:type) }
    it { should belong_to(:severity) }
    it { should have_many(:cycles) }
    it { should have_many(:annotations) }
  end
end
