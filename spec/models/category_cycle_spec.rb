require 'rails_helper'

RSpec.describe CategoryCycle, type: :model do
  describe 'associations' do
    it { should belong_to(:cycle) }
    it { should belong_to(:category) }
  end
end
