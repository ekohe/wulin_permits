class RenameRoleToRoleIdOfUserRolesTable < ActiveRecord::Migration
  def up
    rename_column :user_roles, :role, :role_id if table_exists?(:user_roles) and column_exists?(:user_roles, :role)
  end

  def down
    rename_column :user_roles, :role_id, :role if table_exists?(:user_roles) and column_exists?(:user_roles, :role_id)
  end
end
