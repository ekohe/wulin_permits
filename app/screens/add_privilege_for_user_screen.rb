class AddPrivilegeForUserScreen < WulinMaster::Screen
  title "Available Privileges"

  grid PrivilegeGrid, title: "Available Privileges", master_model: "users"
end
