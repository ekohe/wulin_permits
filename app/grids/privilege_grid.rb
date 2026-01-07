class PrivilegeGrid < WulinMaster::Grid
  title "Privileges"

  model Privilege

  path "/privileges"

  column :name
  column :description, width: 300

  load_default_actions({only: [:MasterRolePrivilegeScreen, :MasterPrivilegeRoleScreen]})

  action :create, only: [:PrivilegeScreen]
  action :delete, only: [:PrivilegeScreen]

  action(:audit) if defined? WulinAudit
end
