# Subjects in our database
class CreateAdditionalSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :additional_subjects do |t|
      t.string :name

      t.timestamps
    end
  end
end
