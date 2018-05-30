require 'rails_helper'

RSpec.describe AdditionalSubject, type: :model do
  describe 'validations' do
    # Create a subject
    # This is needed to prevent validate uniqueness from failing
    subject do
      AdditionalSubject.new(
        name: 'something'
      )
    end
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
