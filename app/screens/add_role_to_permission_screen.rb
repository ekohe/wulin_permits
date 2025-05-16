class AddRoleToPermissionScreen < WulinMaster::Screen
  grid RoleGrid, title: '利用可能なロール', master_model: 'permissions'
end
