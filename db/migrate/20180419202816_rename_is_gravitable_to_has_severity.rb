class RenameIsGravitableToHasSeverity < ActiveRecord::Migration[5.0]
  def change
    rename_column :types, :is_gravitable, :has_severity
  end
end
