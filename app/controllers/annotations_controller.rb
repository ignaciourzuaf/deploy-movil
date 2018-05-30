# controller of annotations
class AnnotationsController < ApplicationController
  before_action :require_admin, only: %i[create update destroy]
  before_action :set_annotation, only: %i[show update destroy]
  before_action :clean_students, only: :update

  # GET /annotations
  def index
    @annotations = if params[:group_id].nil?
                     Annotation.all
                   else
                     Annotation.where(group_id: params[:group_id])
                   end
    render status: :ok, json: @annotations
  end

  def new_index
    @annotations = []
    account_children.each do |student|
      AnnotatedStudent.where(student_id: student['id']).each do |relation|
        @annotations << Annotation.find_by(relation.annotation_id) \
          if current_account['position_id'] == 12
      end
    end
    render status: :ok, json: @annotations.to_json
  end

  # GET /annotations/1
  def show
    render status: :ok, json: @annotation
  end

  # POST /annotations
  def create
    @annotation = Annotation.create!(create_params)
    render status: :created, json: @annotation
  end

  # PATCH/PUT /annotations/1
  def update
    @annotation.update(update_params)
    render status: :ok, json: @annotation
  end

  # DELETE /annotations/1
  def destroy
    @annotation.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_annotation
    @annotation = Annotation.find(params[:id])
  end

  # Students in the annotation
  def clean_students
    add_students_to_remove
    student_ids = @annotation.annotated_students.map(&:student_id)
    params[:annotated_students_attributes]&.delete_if do |h|
      student_ids.include? h[:student_id]
    end
  end

  # Students in current, but not in params
  def add_students_to_remove
    ids = params[:annotated_students_attributes]&.map { |a| a[:student_id] }
    return if ids.nil?
    @annotation.annotated_students.each do |annotated|
      unless ids.include? annotated.student_id
        params[:annotated_students_attributes] << { 'id': annotated.id,
                                                    '_destroy': true }
      end
    end
  end

  def common_params
    %i[detail is_additional_subject
       subject_id category_id
       creator_id date group_id]
  end

  # Only allow a trusted parameter "white list" through.
  def create_params
    permitted = params.permit(*common_params, :is_group,
                              annotated_students_attributes: [:student_id])
    permitted[:annotated_students_attributes] = [] if params[:is_group]
    permitted
  end

  # Update params without group_id
  def update_params
    permitted = params.permit(*common_params,
                              annotated_students_attributes:
                              %i[id student_id _destroy])
    permitted[:annotated_students_attributes] = [] if @annotation.is_group
    permitted
  end
end
