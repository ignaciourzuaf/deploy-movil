class RemoveAdditionalSubjectFromAnnotations < ActiveRecord::Migration[5.0]
  def change
    remove_column :annotations, :additional_subject_id
  end
end
