class RenameRoleToRoleIdOfUserRolesTable < ActiveRecord::Migration
  def up
    rename_column :user_roles, :role, :role_id
  end

  def down
    rename_column :user_roles, :role_id, :role
  end
end
