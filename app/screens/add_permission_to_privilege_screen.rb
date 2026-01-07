class AddPermissionToPrivilegeScreen < WulinMaster::Screen
  grid PermissionGrid, title: "Available Permissions", master_model: "privileges"
end
