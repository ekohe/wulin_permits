class RenameToRolesUsersOfUserRolesTable < ActiveRecord::Migration
  def up
    rename_table :user_roles, :roles_users
  end

  def down
    rename_table :roles_users, :user_roles
  end
end