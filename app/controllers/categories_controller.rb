# Categories controller
class CategoriesController < ApplicationController
  before_action :require_admin, only: %i[create update destroy]
  before_action :set_category, only: %i[show update destroy]
  before_action :set_type, only: %i[create update]
  before_action :check_severity, only: %i[create update]

  # GET /categories
  def index
    @categories = Category.all
    render status: :ok, json: @categories
  end

  # GET /categories/1
  def show
    render status: :ok, json: @category
  end

  # POST /categories
  def create
    @category = Category.create!(category_params)
    render status: :created, json: @category
  end

  # PATCH/PUT /categories/1
  def update
    @category.update(category_params)
    render json: @category
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  def set_type
    type_id = params[:type_id]
    @type = type_id.nil? ? @category&.type : Type.find(type_id)
  end

  def check_severity
    params[:severity_id] = nil unless @type&.has_severity
  end

  # Only allow a trusted parameter "white list" through.
  def category_params
    params.permit(:name, :default_description,
                  :severity_id, :type_id,
                  cycle_ids: [])
  end
end
