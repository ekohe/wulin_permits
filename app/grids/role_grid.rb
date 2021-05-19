class RoleGrid < WulinMaster::Grid
  title 'Roles'

  model Role

  path '/roles'

  column :name

  load_default_actions({only: [:MasterRoleDetailUserScreen]})

  action :create, only: [:RoleScreen, :MasterRolePermissionScreen]
  action :delete, only: [:RoleScreen, :MasterRolePermissionScreen]
end
