# Cycles controller
class CyclesController < ApplicationController
  before_action :require_admin, only: %i[create update destroy]
  before_action :set_cycle, only: %i[show update destroy]
  before_action :clean_cycle_levels, only: :update

  # GET /cycles
  def index
    @cycles = Cycle.all
    render status: :ok, json: @cycles
  end

  # GET /cycles/1
  def show
    render status: :ok, json: @cycle
  end

  # POST /cycles
  def create
    @cycle = Cycle.create!(cycle_params)
    render status: :created, json: @cycle
  end

  # PATCH/PUT /cycles/1
  def update
    @cycle.update(cycle_params)
    render json: @cycle
  end

  # DELETE /cycles/1
  def destroy
    @cycle.destroy
  end

  private

  # Cycle levels in the annotation
  def clean_cycle_levels
    add_cycle_levels_to_remove
    cycle_level_ids = @cycle.cycle_levels.map(&:group_level_id)
    params[:cycle_levels_attributes]&.delete_if do |h|
      cycle_level_ids.include? h[:group_level_id]
    end
  end

  # Cycle levels in current, but not in params
  def add_cycle_levels_to_remove
    ids = params[:cycle_levels_attributes]&.map { |a| a[:group_level_id] }
    return if ids.nil?
    @cycle.cycle_levels.each do |cycle_level|
      unless ids.include? cycle_level.group_level_id
        params[:cycle_levels_attributes] << { 'id': cycle_level.id,
                                              '_destroy': true }
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_cycle
    @cycle = Cycle.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def cycle_params
    params.permit(:name,
                  category_ids: [],
                  cycle_levels_attributes:
                  %i[group_level_id id _destroy])
  end
end
