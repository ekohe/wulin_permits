class PermissionsPrivilegeGrid < WulinMaster::Grid
  title "Permissions Privileges"

  model PermissionsPrivilege

  path "/permissions_privileges"

  column :name, through: :permission, label: "Permission", editable: false, only: [:PrivilegeScreen]
  column :description, through: :permission, editable: false, only: [:PrivilegeScreen]

  column :name, through: :privilege, label: "Privilege", editable: false, only: [:MasterPermissionPrivilegeScreen]

  # actions for PrivilegeScreen (Privilege -> Permissions)
  action :add_detail, icon: :add_circle_outline, model: "permission", screen: "AddPermissionToPrivilegeScreen", title: "Attach Permissions", only: [:PrivilegeScreen]
  action :delete, icon: :remove_circle_outline, title: "Remove Permissions", only: [:PrivilegeScreen]

  # actions for MasterPermissionPrivilegeScreen (Permission -> Privileges)
  action :add_detail, icon: :add_circle_outline, model: "privilege", screen: "AddPrivilegeToPermissionScreen", title: "Attach Privileges", only: [:MasterPermissionPrivilegeScreen]
  action :delete, icon: :remove_circle_outline, title: "Remove Privileges", only: [:MasterPermissionPrivilegeScreen]

  action(:audit) if defined? WulinAudit
end
