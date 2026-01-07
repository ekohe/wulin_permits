class CreatePrivileges < ActiveRecord::Migration[6.1]
  def up
    unless table_exists?(:privileges)
      create_table "privileges" do |t|
        t.string "name"
        t.string "description"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
      end
    end

    unless table_exists?(:roles_privileges)
      create_table "roles_privileges" do |t|
        t.integer "role_id"
        t.integer "privilege_id"
      end
    end

    unless table_exists?(:permissions_privileges)
      create_table "permissions_privileges" do |t|
        t.integer "permission_id"
        t.integer "privilege_id"
      end
    end

    unless table_exists?(:users_privileges)
      create_table "users_privileges" do |t|
        t.integer "user_id"
        t.integer "privilege_id"
      end
    end

    # migrate data
    migrate_privileges
  end

  def down
    drop_table :users_privileges if table_exists?(:users_privileges)
    drop_table :permissions_privileges if table_exists?(:permissions_privileges)
    drop_table :roles_privileges if table_exists?(:roles_privileges)
    drop_table :privileges if table_exists?(:privileges)
  end

  def migrate_privileges
    return if Privilege.exists?

    say_with_time "Migrating roles to privileges..." do
      Role.find_each do |role|
        Privilege.find_or_create_by!(id: role.id) do |privilege|
          privilege.name = role.name
          privilege.description = role.description
        end
      end
    end
    say_with_time "Migrating roles_users to users_privileges..." do
      RolesUser.find_each do |roles_user|
        UsersPrivilege.find_or_create_by!(
          user_id: roles_user.user_id,
          privilege_id: roles_user.role_id
        )
      end
    end
    say_with_time "Migrating permissions_roles to permissions_privileges..." do
      PermissionsRole.find_each do |permissions_role|
        PermissionsPrivilege.find_or_create_by!(
          permission_id: permissions_role.permission_id,
          privilege_id: permissions_role.role_id
        )
      end
    end
    ActiveRecord::Base.connection.reset_pk_sequence! Privilege.table_name
    ActiveRecord::Base.connection.reset_pk_sequence! UsersPrivilege.table_name
    ActiveRecord::Base.connection.reset_pk_sequence! PermissionsPrivilege.table_name
    RolesUser.delete_all
    PermissionsRole.delete_all
    Role.delete_all
  end
end
