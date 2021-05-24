class AddRoleToPermissionScreen < WulinMaster::Screen
  grid RoleGrid, title: 'Available Roles', master_model: 'permissions'
end
