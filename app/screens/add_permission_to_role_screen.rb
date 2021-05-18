class AddPermissionToRoleScreen < WulinMaster::Screen
  grid PermissionGrid, title: 'Available Permissions', master_model: 'roles'
end
