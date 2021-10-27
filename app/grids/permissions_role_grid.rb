class PermissionsRoleGrid < WulinMaster::Grid
  title "Permissions Roles"

  model PermissionsRole

  path "/permissions_roles"

  column :permission, editable: false, only: [:RoleScreen]
  column :description, sql_expression: "#{Permission.table_name}.description", only: [:RoleScreen]

  column :name, through: :role, only: [:MasterPermissionRoleScreen]

  # actions for RoleScreen
  action :add_detail, icon: :add_circle_outline, model: 'permission', screen: 'AddPermissionToRoleScreen', title: 'Attach Permissions', only: [:RoleScreen]
  action :delete, icon: :remove_circle_outline, title: 'Remove Permissions', only: [:RoleScreen]
  # actions for MasterPermissionRoleScreen
  action :add_detail, icon: :add_circle_outline, model: 'role', screen: 'AddRoleToPermissionScreen', title: 'Attach Roles', only: [:MasterPermissionRoleScreen]
  action :delete, icon: :remove_circle_outline, title: 'Remove Roles', only: [:MasterPermissionRoleScreen]
  action(:audit) if defined? WulinAudit
end
