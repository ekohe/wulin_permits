class RolesPrivilegeGrid < WulinMaster::Grid
  title "Roles Privileges"

  model RolesPrivilege

  path "/roles_privileges"

  column :name, through: :privilege, label: "Privilege", editable: false, only: [:MasterRolePrivilegeScreen]
  column :description, through: :privilege, editable: false, only: [:MasterRolePrivilegeScreen]

  column :name, through: :role, label: "Role", editable: false, only: [:PrivilegeScreen, :MasterPrivilegeRoleScreen]

  # actions for MasterRolePrivilegeScreen (Role -> Privileges)
  action :add_detail, icon: :add_circle_outline, model: "privilege", screen: "AddPrivilegeToRoleScreen", title: "Attach Privileges", only: [:MasterRolePrivilegeScreen]
  action :delete, icon: :remove_circle_outline, title: "Remove Privileges", only: [:MasterRolePrivilegeScreen]

  # actions for PrivilegeScreen and MasterPrivilegeRoleScreen (Privilege -> Roles)
  action :add_detail, icon: :add_circle_outline, model: "role", screen: "AddRoleToPrivilegeScreen", title: "Attach Roles", only: [:PrivilegeScreen, :MasterPrivilegeRoleScreen]
  action :delete, icon: :remove_circle_outline, title: "Remove Roles", only: [:PrivilegeScreen, :MasterPrivilegeRoleScreen]

  action(:audit) if defined? WulinAudit
end
