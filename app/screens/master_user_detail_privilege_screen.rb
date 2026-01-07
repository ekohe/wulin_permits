class MasterUserDetailPrivilegeScreen < WulinMaster::Screen
  title "Users Privileges"

  path "/users_privileges"

  grid UserGrid, width: "50%", height: "100%", css: "position: absolute; bottom: 0; left: 0;"
  grid UsersPrivilegeGrid, width: "50%", height: "100%", css: "position: absolute; bottom: 0; right: 0;", title: "Privileges with User", master_grid: "UserGrid", eager_loading: false

  def authorized?(user)
    user.admin?
  end
end
