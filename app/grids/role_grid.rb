class RoleGrid < WulinMaster::Grid
  title 'Roles'

  model Role

  column :name

  load_default_actions({only: [:MasterRoleDetailUserScreen]})

  action :create, only: [:RoleScreen]
  action :delete, only: [:RoleScreen]
end
