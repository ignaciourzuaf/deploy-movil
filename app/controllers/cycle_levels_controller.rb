# Cycle Level controller
class CycleLevelsController < ApplicationController
  before_action :require_admin, only: %i[destroy]
  before_action :set_cycle, only: %i[destroy]

  # DELETE /cycles/:cycle_id/levels/:id
  def destroy
    return @cycle_level.destroy if @cycle_level
    raise ActiveRecord::RecordNotFound
  end

  private

  def set_cycle
    @cycle_level = CycleLevel.find_by(cycle_id: params[:cycle_id],
                                      group_level_id: params[:id])
  end
end
