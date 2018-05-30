# annotations
class CreateAnnotations < ActiveRecord::Migration[5.0]
  def change
    create_table :annotations do |t|
      t.text :detail
      t.boolean :is_additional_subject
      t.references :additional_subject, foreign_key: true
      t.integer :creator_id
      t.references :category, foreign_key: true
      t.integer :group_id
      t.boolean :is_group
      t.timestamps
    end
  end
end
