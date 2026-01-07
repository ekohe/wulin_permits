class MasterPrivilegeRoleScreen < WulinMaster::Screen
  title "Privileges Roles"

  path "/privileges_roles"

  grid PrivilegeGrid, height: "100%", width: "50%", title: "Privileges"
  grid RolesPrivilegeGrid, height: "100%", width: "50%", title: "Roles", master_grid: "PrivilegeGrid", eager_loading: false

  def authorized?(user)
    user&.admin?
  end
end
