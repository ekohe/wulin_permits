class AddDescriptionToPermissions < ActiveRecord::Migration
  def up
    add_column(:permissions, :description, :string) if table_exists?(:permissions) and !column_exists?(:permissions, :description)
  end

  def down
    remove_column(:permissions, :description) if table_exists?(:permissions) and column_exists?(:permissions, :description)
  end
end
