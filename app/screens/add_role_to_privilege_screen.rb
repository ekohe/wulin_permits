class AddRoleToPrivilegeScreen < WulinMaster::Screen
  grid RoleGrid, title: "Available Roles", master_model: "privileges"
end
