class RoleGrid < WulinMaster::Grid
  title 'Roles'

  model Role

  column :name
  
  load_default_actions({only: [:MasterRoleDetailUserScreen]})

  action :filter, only: [:AddRoleForUserScreen]
end