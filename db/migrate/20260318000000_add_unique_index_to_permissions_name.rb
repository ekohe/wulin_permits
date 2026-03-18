class AddUniqueIndexToPermissionsName < ActiveRecord::Migration[7.1]
  def change
    add_index :permissions, :name, unique: true, name: "uniq_permissions_name", if_not_exists: true
  end
end
