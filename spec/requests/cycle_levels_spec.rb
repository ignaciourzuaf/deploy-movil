require 'rails_helper'

RSpec.describe 'CycleLevels', type: :request do
  let!(:cycle_levels) { create_list(:cycle_level, 3) }
  let(:cycle_id) { cycle_levels.first.cycle_id }
  let(:group_level_id) { cycle_levels.first.group_level_id }
  let(:basic_params) { papinotas_query_params }

  let(:valid_attributes) do
    {
      cycle_id: 1,
      level_id: 1
    }.merge(basic_params)
  end
  let(:invalid_attributes) { { group_level_id: '' }.merge(basic_params) }

  let(:valid_admin_headers) { papinotas_headers_admin }
  let(:valid_basic_headers) { papinotas_headers_basic }
  let(:invalid_headers) { {} }

  describe 'DELETE /cycles/:annotation_id/levels/:id' do
    context 'when the record exists for admin account' do
      before do
        delete "/cycles/#{cycle_id}/levels/#{group_level_id}",
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        delete '/cycles/1000000/levels/10000',
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        delete "/cycles/#{cycle_id}/levels/#{group_level_id}",
               params: basic_params,
               headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        delete "/cycles/#{cycle_id}/levels/#{group_level_id}",
               params: basic_params,
               headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
