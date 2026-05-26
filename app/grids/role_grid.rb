class RoleGrid < WulinMaster::Grid
  title 'Roles'

  model Role

  path '/roles'

  column :name
  column :description
  column :user_id, through: :roles_users, source: :user_id, visible: false, editable: false, formable: false, only: [:AddRoleForUserScreen]

  load_default_actions({only: [:MasterRoleDetailUserScreen, :MasterRolePrivilegeScreen]})

  action :create, only: [:RoleScreen]
  action :delete, only: [:RoleScreen]

  action(:audit) if defined? WulinAudit
end
