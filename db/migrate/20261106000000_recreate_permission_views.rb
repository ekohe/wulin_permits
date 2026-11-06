# CreatePermissionViews ran in apps whose db/schema.rb was dumped before this gem brought scenic, so
# their dumps hold no views. A database loaded from such a dump has every migration marked as run and
# neither view -- and nothing would ever create them, nor could scenic dump what is not there. Running
# the same CREATE OR REPLACE statements again restores them; where they exist it changes nothing.
class RecreatePermissionViews < ActiveRecord::Migration[6.1]
  def up
    views_path = File.expand_path("../../views", __FILE__)

    execute File.read(File.join(views_path, "1_user_all_permissions.sql"))
    execute File.read(File.join(views_path, "2_permission_all_users.sql"))
  end

  # The views belong to CreatePermissionViews, which drops them on its own rollback.
  def down
  end
end
