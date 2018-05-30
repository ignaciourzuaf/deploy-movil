class AddSubjectIdToAnnotations < ActiveRecord::Migration[5.0]
  def change
    add_column :annotations, :subject_id, :integer
  end
end
