# controller of join table between students and annotations
class AnnotatedStudentsController < ApplicationController
  before_action :require_admin, only: %i[destroy]
  before_action :set_annotated_student, only: %i[destroy]

  # DELETE /annotations/:annotation_id/students/:id
  def destroy
    return @annotated_student.destroy if @annotated_student
    raise ActiveRecord::RecordNotFound
  end

  private

  def set_annotated_student
    @annotated_student = AnnotatedStudent.find_by(
      annotation_id: params[:annotation_id],
      student_id: params[:id]
    )
  end
end
