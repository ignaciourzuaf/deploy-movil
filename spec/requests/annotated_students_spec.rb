require 'rails_helper'

RSpec.describe 'AnnotatedStudents', type: :request do
  let!(:annotated_students) { create_list(:annotated_student, 3) }
  let(:annotated_student_id) { annotated_students.first.id }
  let(:annotation_id) { annotated_students.first.annotation_id }

  let(:basic_params) { papinotas_query_params }

  let(:valid_attributes) do
    {
      student_id: 1,
      annotation_id: annotation_id
    }.merge(basic_params)
  end
  let(:invalid_attributes) { { student_id: '' }.merge(basic_params) }

  let(:valid_admin_headers) { papinotas_headers_admin }
  let(:valid_basic_headers) { papinotas_headers_basic }
  let(:invalid_headers) { {} }

  describe 'DELETE /annotations/:annotation_id/students/:id' do
    context 'when the record exists for admin account' do
      before do
        delete "/annotations/#{annotation_id}/students/#{annotated_student_id}",
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist for admin account' do
      before do
        delete '/annotations/1000000/students/10000',
               params: basic_params,
               headers: valid_admin_headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request comes from basic account' do
      before do
        delete "/annotations/#{annotation_id}/students/#{annotated_student_id}",
               params: basic_params,
               headers: valid_basic_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the credentials are invalid' do
      before do
        delete "/annotations/#{annotation_id}/students/#{annotated_student_id}",
               params: basic_params,
               headers: invalid_headers
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
