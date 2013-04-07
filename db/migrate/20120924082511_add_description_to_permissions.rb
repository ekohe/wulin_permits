class AddDescriptionToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :description, :string if table_exists?(:permissions) and !column_exists?(:permissions, :description)
  end
end
