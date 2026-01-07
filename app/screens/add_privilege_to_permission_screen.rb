class AddPrivilegeToPermissionScreen < WulinMaster::Screen
  grid PrivilegeGrid, title: "Available Privileges", master_model: "permissions"
end
