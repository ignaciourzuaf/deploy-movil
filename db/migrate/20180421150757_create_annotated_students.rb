# creating annotated students
class CreateAnnotatedStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :annotated_students do |t|
      t.integer :student_id
      t.references :annotation, foreign_key: true
      t.timestamps
    end
  end
end
