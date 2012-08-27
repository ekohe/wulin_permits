class AddRoleForUserScreen < WulinMaster::Screen
  title "Available Roles"

  grid RoleGrid, title: 'Available Roles', master_model: 'users'
end