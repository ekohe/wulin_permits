class AddUserForPrivilegeScreen < WulinMaster::Screen
  title "Available Users"

  grid UserGrid, title: "Available Users", master_model: "privileges", multi_select: true
end
