require 'rails_helper'

RSpec.describe AdditionalSubjectsController,
               type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/additional_subjects').to route_to(
        'additional_subjects#index'
      )
    end
    it 'routes to #create' do
      expect(post: '/additional_subjects').to route_to(
        'additional_subjects#create'
      )
    end
    it 'routes to #update via PUT' do
      expect(put: '/additional_subjects/1').to route_to(
        'additional_subjects#update', id: '1'
      )
    end
    it 'routes to #destroy' do
      expect(delete: '/additional_subjects/1').to route_to(
        'additional_subjects#destroy', id: '1'
      )
    end
  end
end
