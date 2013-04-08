class RenameToRolesUsersOfUserRolesTable < ActiveRecord::Migration
  def up
    rename_table :user_roles, :roles_users if !table_exists?(:roles_users) and !const_defined?('TerranovaCore')
  end

  def down
    rename_table :roles_users, :user_roles if !table_exists?(:user_roles) and !const_defined?('TerranovaCore')
  end
end