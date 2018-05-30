# controller of additional subjects
class AdditionalSubjectsController < ApplicationController
  before_action :set_additional_subject, only: %i[show update destroy]
  before_action :require_admin, only: %i[create update destroy]

  # GET /additional_subjects
  def index
    @additional_subjects = AdditionalSubject.all
    render status: :ok, json: @additional_subjects
  end

  # GET /additional_subjects/1
  def show
    render status: :ok, json: @additional_subject
  end

  # POST /additional_subjects
  def create
    @additional_subject = AdditionalSubject.create!(additional_subject_params)
    render status: :created, json: @additional_subject
  end

  # PATCH/PUT /additional_subjects/1
  def update
    @additional_subject.update(additional_subject_params)
    render json: @additional_subject
  end

  # DELETE /additional_subjects/1
  def destroy
    @additional_subject.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_additional_subject
    @additional_subject = AdditionalSubject.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def additional_subject_params
    params.permit(:name)
  end
end
