class CreatePermissionViews < ActiveRecord::Migration[6.1]
  def up
    views_path = File.expand_path("../../views", __FILE__)

    execute File.read(File.join(views_path, "1_user_all_permissions.sql"))
    execute File.read(File.join(views_path, "2_permission_all_users.sql"))
  end

  def down
    execute "DROP VIEW IF EXISTS public.permission_all_users"
    execute "DROP VIEW IF EXISTS public.user_all_permissions"
  end
end

