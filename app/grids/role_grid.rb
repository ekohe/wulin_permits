class RoleGrid < WulinMaster::Grid
  title 'ロール'

  model Role

  path '/roles'

  column :name
  column :description

  load_default_actions({only: [:MasterRoleDetailUserScreen]})

  action :create, only: [:RoleScreen]
  action :delete, only: [:RoleScreen]

  action(:audit) if defined? WulinAudit
end
