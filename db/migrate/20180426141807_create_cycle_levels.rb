class CreateCycleLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :cycle_levels do |t|
      t.references :cycle, foreign_key: true
      t.integer :group_level_id

      t.timestamps
    end
  end
end
