class AddDateToAnnotations < ActiveRecord::Migration[5.0]
  def change
    add_column :annotations, :date, :date
  end
end
