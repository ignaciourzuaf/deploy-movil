# Types controller
class TypesController < ApplicationController
  before_action :require_admin, only: %i[create update destroy]
  before_action :set_type, only: %i[show update destroy]

  # GET /types
  def index
    @types = Type.all

    render status: :ok, json: @types
  end

  # GET /types/1
  def show
    render status: :ok, json: @type
  end

  # POST /types
  def create
    @type = Type.create!(type_params)
    render status: :created, json: @type
  end

  # PATCH/PUT /types/1
  def update
    @type.update(type_params)
    render json: @type
  end

  # DELETE /types/1
  def destroy
    @type.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_type
    @type = Type.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def type_params
    params.permit(:name, :has_severity)
  end
end
