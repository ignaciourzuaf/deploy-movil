require 'rails_helper'

RSpec.describe 'Annotations', type: :request do
  let(:additional_subject) { create(:additional_subject) }
  let!(:annotations) do
    create_list(:annotation,
                3,
                subject_id: additional_subject.id)
  end
  let(:annotation_id) { annotations.first.id }
  let(:annotated_student) do
    create(:annotated_student,
           annotation_id: annotation_id)
  end
  let(:category_id) { annotations.first.category_id }
  let(:subject_id) { annotations.first.subject_id }

  let(:basic_params) { papinotas_query_params }

  let(:valid_attributes) do
    {
      detail: 'text',
      is_additional_subject: true,
      creator_id: 1,
      category_id: category_id,
      group_id: 1,
      is_group: true,
      date: '01-01-2018',
      subject_id: additional_subject.id
    }.merge(basic_params)
  end
  let(:invalid_attributes) do
    { detail: '' }.merge(basic_params)
  end

  let(:valid_admin_headers) { papinotas_headers_admin }
  let(:valid_basic_headers) { papinotas_headers_basic }
  let(:invalid_headers) { {} }

  describe 'GET /annotations' do
    context 'when the credentials are valid for admin account' do
      before do
        get '/annotations',
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns annotations' do
        expect(json).not_to be_empty
        expect(json['annotations'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are valid for basic account' do
      before do
        get '/annotations',
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns annotations' do
        expect(json).not_to be_empty
        expect(json['annotations'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get '/annotations', params: basic_params, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /annotations/:id' do
    context 'when the record exists for admin account' do
      before do
        get "/annotations/#{annotation_id}",
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['annotation']['id']).to eq(annotation_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record exists for basic account' do
      before do
        get "/annotations/#{annotation_id}",
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['annotation']['id']).to eq(annotation_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        get '/annotations/100',
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match("Couldn't find Annotation with 'id'=100")
      end
    end

    context 'when the record does not exist for basic account' do
      before do
        get '/annotations/100',
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match("Couldn't find Annotation with 'id'=100")
      end
    end

    context 'when the credentials are invalid' do
      before do
        get "/annotations/#{annotation_id}",
            params: basic_params,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST /annotations' do
    context 'when the request is valid for admin account' do
      before do
        post '/annotations',
             params: valid_attributes,
             headers: valid_admin_headers
      end

      it 'creates a category' do
        expect(json['annotation']['detail']).to eq('text')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the params are invalid for admin account' do
      before do
        post '/annotations', params: invalid_attributes,
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
        post '/annotations', params: valid_attributes,
                             headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        post '/annotations', params: valid_attributes, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /annotations/:id' do
    context 'when the record exists for admin account' do
      before do
        put "/annotations/#{annotation_id}",
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'updates the record' do
        expect(json['annotation']['detail']).to eq('text')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        put '/annotations/10000',
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        put "/annotations/#{annotation_id}",
            params: valid_attributes,
            headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        put "/annotations/#{annotation_id}",
            params: valid_attributes,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /annotations/:id' do
    context 'when the record exists for admin account' do
      before do
        delete "/annotations/#{annotation_id}",
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        delete '/annotations/10000',
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        delete "/annotations/#{annotation_id}",
               params: basic_params,
               headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        delete "/annotations/#{annotation_id}",
               params: basic_params,
               headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
