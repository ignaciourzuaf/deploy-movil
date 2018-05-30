class CreateCategoryCycles < ActiveRecord::Migration[5.0]
  def change
    create_table :category_cycles do |t|
      t.belongs_to :category
      t.belongs_to :cycle

      t.timestamps
    end
  end
end
