require 'rails_helper'

RSpec.describe 'Severities', type: :request do
  let!(:severities) { create_list(:severity, 3) }
  let(:severity_id) { severities.first.id }

  let(:basic_params) { papinotas_query_params }

  let(:valid_attributes) { { name: 'grave' }.merge(basic_params) }
  let(:invalid_attributes) { { name: '' }.merge(basic_params) }

  let(:valid_admin_headers) { papinotas_headers_admin }
  let(:valid_basic_headers) { papinotas_headers_basic }
  let(:invalid_headers) { {} }

  describe 'GET /severities' do
    context 'when the credentials are valid for admin account' do
      before do
        get '/severities',
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns severities' do
        expect(json).not_to be_empty
        expect(json['severities'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are valid for basic account' do
      before do
        get '/severities',
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns severities' do
        expect(json).not_to be_empty
        expect(json['severities'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get '/severities', params: basic_params, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /severities/:id' do
    context 'when the record exists for admin account' do
      before do
        get "/severities/#{severity_id}",
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns the severity' do
        expect(json).not_to be_empty
        expect(json['severity']['id']).to eq(severity_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record exists for basic account' do
      before do
        get "/severities/#{severity_id}",
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns the severity' do
        expect(json).not_to be_empty
        expect(json['severity']['id']).to eq(severity_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        get '/severities/10000',
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match(/Couldn't find Severity/)
      end
    end

    context 'when the record does not exist for basic account' do
      before do
        get '/severities/10000',
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match(/Couldn't find Severity/)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get "/severities/#{severity_id}",
            params: basic_params,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST /severities' do
    context 'when the request is valid for admin account' do
      before do
        post '/severities',
             params: valid_attributes,
             headers: valid_admin_headers
      end

      it 'creates a severity' do
        expect(json['severity']['name']).to eq('grave')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the params are invalid for admin account' do
      before do
        post '/severities',
             params: invalid_attributes,
             headers: valid_admin_headers
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
        post '/severities',
             params: valid_attributes,
             headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        post '/severities', params: valid_attributes, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /severities/:id' do
    context 'when the record exists for admin account' do
      before do
        put "/severities/#{severity_id}",
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'updates the record' do
        expect(json['severity']['name']).to eq('grave')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        put '/severities/10000',
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        put "/severities/#{severity_id}",
            params: valid_attributes,
            headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        put "/severities/#{severity_id}",
            params: valid_attributes,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /severities/:id' do
    context 'when the record exists for admin account' do
      before do
        delete "/severities/#{severity_id}",
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        delete '/severities/10000',
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        delete "/severities/#{severity_id}",
               params: basic_params,
               headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        delete "/severities/#{severity_id}",
               params: basic_params,
               headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
