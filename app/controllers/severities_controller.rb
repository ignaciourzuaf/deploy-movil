# Severities controller
class SeveritiesController < ApplicationController
  before_action :set_severity, only: %i[show update destroy]
  before_action :require_admin, only: %i[create update destroy]

  # GET /severities
  def index
    @severities = Severity.all

    render json: @severities
  end

  # GET /severities/1
  def show
    render json: @severity
  end

  # POST /severities
  def create
    @severity = Severity.create!(severity_params)
    render status: :created, json: @severity
  end

  # PATCH/PUT /severities/1
  def update
    @severity.update(severity_params)
    render json: @severity
  end

  # DELETE /severities/1
  def destroy
    @severity.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_severity
    @severity = Severity.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def severity_params
    params.permit(:name)
  end
end
