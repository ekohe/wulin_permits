class PrivilegeScreen < WulinMaster::Screen
  title "Privileges Permissions"

  path "/privileges"

  grid PrivilegeGrid, height: "100%", width: "50%", title: "Privilege"
  grid PermissionsPrivilegeGrid, height: "100%", width: "50%", title: "Existing permissions", master_grid: "PrivilegeGrid", eager_loading: false

  def authorized?(user)
    user&.admin?
  end
end
