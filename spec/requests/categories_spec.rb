require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:type) { create(:type) }
  let(:cycles) { create_list(:cycle, 3) }
  let(:cycle_ids) { cycles.map(&:id) }
  let!(:categories) { create_list(:category, 3, type_id: type.id) }
  let(:category_id) { categories.first.id }
  let(:severity) { create(:severity) }

  let(:basic_params) { papinotas_query_params }

  let(:valid_attributes) do
    {
      name: 'categoria',
      default_description: 'descripcion',
      type_id: type.id,
      cycle_ids: cycle_ids,
      severity_id: severity.id
    }.merge(basic_params)
  end
  let(:invalid_attributes) do
    { type_id: type.id }.merge(basic_params)
  end

  let(:valid_admin_headers) { papinotas_headers_admin }
  let(:valid_basic_headers) { papinotas_headers_basic }
  let(:invalid_headers) { {} }

  describe 'GET /categories' do
    context 'when the credentials are valid for admin account' do
      before do
        get '/categories',
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns categories' do
        expect(json).not_to be_empty
        expect(json['categories'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are valid for basic account' do
      before do
        get '/categories',
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns categories' do
        expect(json).not_to be_empty
        expect(json['categories'].size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get '/categories', params: basic_params, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /categories/:id' do
    context 'when the record exists for admin account' do
      before do
        get "/categories/#{category_id}",
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['category']['id']).to eq(category_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record exists for basic account' do
      before do
        get "/categories/#{category_id}",
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['category']['id']).to eq(category_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        get '/categories/100',
            params: basic_params,
            headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match(/Couldn't find Category/)
      end
    end

    context 'when the record does not exist for basic account' do
      before do
        get '/categories/100',
            params: basic_params,
            headers: valid_basic_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_message).to match(/Couldn't find Category/)
      end
    end

    context 'when the credentials are invalid' do
      before do
        get "/categories/#{category_id}",
            params: basic_params,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST /categories' do
    context 'when the request is valid for admin account' do
      before do
        post '/categories',
             params: valid_attributes,
             headers: valid_admin_headers
      end

      it 'creates a category' do
        expect(json['category']['name']).to eq('categoria')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the params are invalid for admin account' do
      before do
        post '/categories',
             params: invalid_attributes,
             headers: valid_admin_headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the request is valid for basic account' do
      before do
        post '/categories',
             params: valid_attributes,
             headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        post '/categories', params: valid_attributes, headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /categories/:id' do
    context 'when the record exists for admin account' do
      before do
        put "/categories/#{category_id}",
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'updates the record' do
        expect(json['category']['name']).to eq('categoria')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        put '/categories/10000',
            params: valid_attributes,
            headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        put "/categories/#{category_id}",
            params: valid_attributes,
            headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        put "/categories/#{category_id}",
            params: valid_attributes,
            headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /categories/:id' do
    context 'when the record exists for admin account' do
      before do
        delete "/categories/#{category_id}",
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        delete '/categories/10000',
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        delete "/categories/#{category_id}",
               params: basic_params,
               headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        delete "/categories/#{category_id}",
               params: basic_params,
               headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
