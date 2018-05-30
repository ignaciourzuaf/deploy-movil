class CreateCycles < ActiveRecord::Migration[5.0]
  def change
    create_table :cycles do |t|
      t.string :name

      t.timestamps
    end
  end
end
