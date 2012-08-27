class AddUserForRoleScreen < WulinMaster::Screen
  title "Available Users"

  grid UserGrid, title: 'Available Users', master_model: 'roles'
end