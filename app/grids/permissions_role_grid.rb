class PermissionsRoleGrid < WulinMaster::Grid
  title "Permissions Roles"

  model PermissionsRole

  path "/permissions_roles"

  column :permission, editable: false, only: [:MasterRolePermissionScreen]
  column :description, sql_expression: "#{Permission.table_name}.description", only: [:MasterRolePermissionScreen]

  column :name, through: :role, only: [:MasterPermissionRoleScreen]

  # actions for MasterRolePermissionScreen
  action :add_detail, icon: :add_circle_outline, model: 'permission', screen: 'AddPermissionToRoleScreen', title: 'Attach Permissions', only: [:MasterRolePermissionScreen]
  action :delete, icon: :remove_circle_outline, title: 'Remove Permissions', only: [:MasterRolePermissionScreen]
  # actions for MasterPermissionRoleScreen
  action :add_detail, icon: :add_circle_outline, model: 'role', screen: 'AddRoleToPermissionScreen', title: 'Roles', only: [:MasterPermissionRoleScreen]
  action :delete, icon: :remove_circle_outline, title: 'Remove Roles', only: [:MasterPermissionRoleScreen]
end
