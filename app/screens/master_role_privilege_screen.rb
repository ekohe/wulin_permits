class MasterRolePrivilegeScreen < WulinMaster::Screen
  title "Roles Privileges"

  path "/roles"

  grid RoleGrid, height: "100%", width: "50%", title: "Roles"
  grid RolesPrivilegeGrid, height: "100%", width: "50%", title: "Privileges", master_grid: "RoleGrid", eager_loading: false

  def authorized?(user)
    user&.admin?
  end
end
