require 'rails_helper'

RSpec.describe SeveritiesController, type: :routing do
  subject(:annotated_student) { create(:annotated_student) }
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/severities').to route_to('severities#index')
    end

    it 'routes to #show' do
      expect(get: '/severities/1').to route_to('severities#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/severities').to route_to('severities#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/severities/1').to route_to('severities#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/severities/1').to route_to('severities#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/severities/1').to route_to('severities#destroy', id: '1')
    end
  end
end
