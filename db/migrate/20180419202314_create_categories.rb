class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :default_description
      t.references :severity, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
