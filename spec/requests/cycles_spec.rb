require 'rails_helper'

RSpec.describe 'Cycles', type: :request do
  let(:type) { create(:type) }
  let(:categories) { create_list(:category, 3, type_id: type.id) }
  let(:category_ids) { categories.map(&:id) }
  let!(:cycles) { create_list(:cycle, 3) }
  let(:cycle_id) { cycles.first.id }

  let(:basic_params) { papinotas_query_params }

  let(:valid_attributes) do
    {
      name: 'ciclo 1',
      group_level_ids: [1, 2, 3],
      category_ids: category_ids
    }.merge(basic_params)
  end
  let(:invalid_attributes) { { name: '' }.merge(basic_params) }

  let(:valid_admin_headers) { papinotas_headers_admin }
  let(:valid_basic_headers) { papinotas_headers_basic }
  let(:invalid_headers) { {} }

  describe 'GET /cycles' do
    context 'when the credentials are valid for admin account' do
      before do
        get '/cycles',
            params: basic_params,
            headers: valid_admin_headers
      end
      it 'returns cycles' do
        expect(json).not_to be_empty
        expect(json['cycles'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are valid for basic account' do
      before do
        get '/cycles',
            params: basic_params,
            headers: valid_basic_headers
      end
      it 'returns cycles' do
        expect(json).not_to be_empty
        expect(json['cycles'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get '/cycles', params: basic_params, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /cycles/:id' do
    context 'when the record exists for admin account' do
      before do
        get "/cycles/#{cycle_id}",
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns the cycle' do
        expect(json).not_to be_empty
        expect(json['cycle']['id']).to eq(cycle_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record exists for basic account' do
      before do
        get "/cycles/#{cycle_id}",
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns the cycle' do
        expect(json).not_to be_empty
        expect(json['cycle']['id']).to eq(cycle_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        get '/cycles/100', params: basic_params, headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match(/Couldn't find Cycle/)
      end
    end

    context 'when the record does not exist for basic account' do
      before do
        get '/cycles/100', params: basic_params, headers: valid_basic_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match(/Couldn't find Cycle/)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get "/cycles/#{cycle_id}",
            params: basic_params,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST /cycles' do
    context 'when the request is valid for admin account' do
      before do
        post '/cycles', params: valid_attributes, headers: valid_admin_headers
      end

      it 'creates a cycle' do
        expect(json['cycle']['name']).to eq('ciclo 1')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the params are invalid for admin account' do
      before do
        post '/cycles', params: invalid_attributes, headers: valid_admin_headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json_message).to match(/can't be blank/)
      end
    end

    context 'when the request is valid for basic account' do
      before do
        post '/cycles', params: valid_attributes, headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        post '/cycles', params: valid_attributes, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /cycles/:id' do
    context 'when the record exists for admin account' do
      before do
        put "/cycles/#{cycle_id}",
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'updates the record' do
        expect(json['cycle']['name']).to eq('ciclo 1')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        put '/cycles/10000',
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        put "/cycles/#{cycle_id}",
            params: valid_attributes,
            headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        put "/cycles/#{cycle_id}",
            params: valid_attributes,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /cycles/:id' do
    context 'when the record exists for admin account' do
      before do
        delete "/cycles/#{cycle_id}",
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        delete '/cycles/10000',
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        delete "/cycles/#{cycle_id}",
               params: basic_params,
               headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        delete "/cycles/#{cycle_id}",
               params: basic_params,
               headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
