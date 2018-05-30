class CreateTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :types do |t|
      t.string :name, null: false
      t.boolean :is_gravitable, default: false

      t.timestamps
    end
  end
end
