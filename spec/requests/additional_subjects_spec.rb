require 'rails_helper'

RSpec.describe 'AdditionalSubjects', type: :request do
  let!(:subjects) { create_list(:additional_subject, 3) }
  let(:subject_id) { subjects.first.id }

  let(:basic_params) { papinotas_query_params }

  let(:valid_attributes) do
    {
      name: 'patio'
    }.merge(basic_params)
  end
  let(:invalid_attributes) { { name: '' }.merge(basic_params) }

  let(:valid_admin_headers) { papinotas_headers_admin }
  let(:valid_basic_headers) { papinotas_headers_basic }
  let(:invalid_headers) { {} }

  describe 'GET /additional_subjects' do
    context 'when the credentials are valid for admin account' do
      before do
        get '/additional_subjects',
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns additional_subjects' do
        expect(json).not_to be_empty
        expect(json['additional_subjects'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are valid for basic account' do
      before do
        get '/additional_subjects',
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns additional_subjects' do
        expect(json).not_to be_empty
        expect(json['additional_subjects'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get '/additional_subjects', params: basic_params,
                                    headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST /additional_subjects' do
    context 'when the request is valid for admin account' do
      before do
        post '/additional_subjects', params: valid_attributes,
                                     headers: valid_admin_headers
      end

      it 'creates a additional_subject' do
        expect(json['additional_subject']['name']).to eq('patio')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the params are invalid for admin account' do
      before do
        post '/additional_subjects', params: invalid_attributes,
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
        post '/additional_subjects', params: valid_attributes,
                                     headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        post '/additional_subjects', params: valid_attributes,
                                     headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /additional_subjects/:id' do
    context 'when the record exists for admin account' do
      before do
        put "/additional_subjects/#{subject_id}",
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'updates the record' do
        expect(json['additional_subject']['name']).to eq('patio')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        put '/additional_subjects/10000',
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        put "/additional_subjects/#{subject_id}",
            params: valid_attributes,
            headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        put "/additional_subjects/#{subject_id}",
            params: valid_attributes,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /additional_subjects/:id' do
    context 'when the record exists for admin account' do
      before do
        delete "/additional_subjects/#{subject_id}",
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        delete '/additional_subjects/10000',
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        delete "/additional_subjects/#{subject_id}",
               params: basic_params,
               headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        delete "/additional_subjects/#{subject_id}",
               params: basic_params,
               headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
