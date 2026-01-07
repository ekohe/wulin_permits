class AddPrivilegeToRoleScreen < WulinMaster::Screen
  grid PrivilegeGrid, title: "Available Privileges", master_model: "roles"
end
