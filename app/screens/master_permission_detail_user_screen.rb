class MasterPermissionDetailUserScreen < WulinMaster::Screen
  title "Permissions Users"

  path "/permission_all_users"

  grid PermissionGrid, width: "50%", height: "100%", css: "position: absolute; bottom: 0; left: 0;"
  grid PermissionAllUserGrid, width: "50%", height: "100%", css: "position: absolute; bottom: 0; right: 0;", title: "Users for Permission", master_grid: "PermissionGrid", eager_loading: false

  def authorized?(user)
    user.admin?
  end
end
