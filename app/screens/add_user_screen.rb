class AddUserScreen < WulinMaster::Screen
  title "Mima Users"

  grid InvitedUserGrid, title: 'Mima Users', master_model: 'users'
end