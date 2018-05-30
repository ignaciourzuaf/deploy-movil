require 'rails_helper'

RSpec.describe Severity, type: :model do
  describe 'validations' do
    # Create a subject
    # This is needed to prevent validate uniqueness from failing
    subject { Severity.new(name: 'something') }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'associations' do
    it { should have_many(:categories) }
  end
end
