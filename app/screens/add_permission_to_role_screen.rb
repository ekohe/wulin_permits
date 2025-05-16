class AddPermissionToRoleScreen < WulinMaster::Screen
  grid PermissionGrid, title: '利用可能な権限', master_model: 'roles'
end
