class AddRoleForUserScreen < WulinMaster::Screen
  title "Available Roles"

  grid RoleGrid, title: '利用可能なロール', master_model: 'users'
end