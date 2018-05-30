require 'rails_helper'

RSpec.describe 'Types', type: :request do
  let!(:types) { create_list(:type, 3) }
  let(:type_id) { types.first.id }

  let(:basic_params) { papinotas_query_params }

  let(:valid_attributes) do
    {
      name: 'positiva',
      has_severity: true
    }.merge(basic_params)
  end
  let(:invalid_attributes) do
    { name: '' }.merge(basic_params)
  end

  let(:valid_admin_headers) { papinotas_headers_admin }
  let(:valid_basic_headers) { papinotas_headers_basic }
  let(:invalid_headers) { {} }

  describe 'GET /types' do
    context 'when the credentials are valid for admin account' do
      before do
        get '/types',
            params: basic_params,
            headers: valid_admin_headers
      end
      it 'returns types' do
        expect(json).not_to be_empty
        expect(json['types'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are valid for basic account' do
      before do
        get '/types',
            params: basic_params,
            headers: valid_basic_headers
      end
      it 'returns types' do
        expect(json).not_to be_empty
        expect(json['types'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get '/types', params: basic_params, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /types/:id' do
    context 'when the record exists for admin account' do
      before do
        get "/types/#{type_id}",
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns the type' do
        expect(json).not_to be_empty
        expect(json['type']['id']).to eq(type_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record exists for basic account' do
      before do
        get "/types/#{type_id}",
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns the type' do
        expect(json).not_to be_empty
        expect(json['type']['id']).to eq(type_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        get '/types/100', params: basic_params, headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match(/Couldn't find Type/)
      end
    end

    context 'when the record does not exist for basic account' do
      before do
        get '/types/100', params: basic_params, headers: valid_basic_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match(/Couldn't find Type/)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get "/types/#{type_id}",
            params: basic_params,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST /types' do
    context 'when the request is valid for admin account' do
      before do
        post '/types',
             params: valid_attributes,
             headers: valid_admin_headers
      end

      it 'creates a type' do
        expect(json['type']['name']).to eq('positiva')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the params are invalid for admin account' do
      before do
        post '/types', params: invalid_attributes, headers: valid_admin_headers
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
        post '/types', params: valid_attributes, headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        post '/types', params: valid_attributes, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /types/:id' do
    context 'when the record exists for admin account' do
      before do
        put "/types/#{type_id}",
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'updates the record' do
        expect(json['type']['name']).to eq('positiva')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        put '/types/10000',
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        put "/types/#{type_id}",
            params: valid_attributes,
            headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        put "/types/#{type_id}",
            params: valid_attributes,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /types/:id' do
    context 'when the record exists for admin account' do
      before do
        delete "/types/#{type_id}",
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        delete '/types/10000',
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        delete "/types/#{type_id}",
               params: basic_params,
               headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        delete "/types/#{type_id}",
               params: basic_params,
               headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
