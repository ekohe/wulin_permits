class MasterUserDetailPermissionScreen < WulinMaster::Screen
  title "Users Permissions"

  path "/user_all_permissions"

  grid UserGrid, width: "50%", height: "100%", css: "position: absolute; bottom: 0; left: 0;"
  grid UserAllPermissionGrid, width: "50%", height: "100%", css: "position: absolute; bottom: 0; right: 0;", title: "Permissions for User", master_grid: "UserGrid", eager_loading: false

  def authorized?(user)
    user.admin?
  end
end