class MasterPermissionPrivilegeScreen < WulinMaster::Screen
  title "Privileges Permissions"

  path "/permissions"

  grid PermissionGrid, height: "100%", width: "50%", title: "Permissions"
  grid PermissionsPrivilegeGrid, height: "100%", width: "50%", title: "Privileges", master_grid: "PermissionGrid", eager_loading: false

  def authorized?(user)
    user&.admin?
  end
end
