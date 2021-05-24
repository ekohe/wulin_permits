class AddRoleToPermissionScreen < WulinMaster::Screen
  grid RoleGrid, title: 'Available Roles', master_model: 'permission'
end
