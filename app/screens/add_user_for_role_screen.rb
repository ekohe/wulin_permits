class AddUserForRoleScreen < WulinMaster::Screen
  title "利用可能なユーザー"

  grid UserGrid, title: '利用可能なユーザー', master_model: 'roles', multi_select: true
end