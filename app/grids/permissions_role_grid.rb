class PermissionsRoleGrid < WulinMaster::Grid
  title "権限ロール"

  model PermissionsRole

  path "/permissions_roles"

  column :permission, editable: false, only: [:RoleScreen]
  column :description, sql_expression: "#{Permission.table_name}.description", only: [:RoleScreen]

  column :name, through: :role, only: [:MasterPermissionRoleScreen]

  # actions for RoleScreen
  action :add_detail, icon: :add_circle_outline, model: 'permission', screen: 'AddPermissionToRoleScreen', title: '権限を追加', only: [:RoleScreen]
  action :delete, icon: :remove_circle_outline, title: '権限を削除', only: [:RoleScreen]
  # actions for MasterPermissionRoleScreen
  action :add_detail, icon: :add_circle_outline, model: 'role', screen: 'AddRoleToPermissionScreen', title: 'ロールを追加', only: [:MasterPermissionRoleScreen]
  action :delete, icon: :remove_circle_outline, title: 'ロールを削除', only: [:MasterPermissionRoleScreen]
  action(:audit) if defined? WulinAudit
end
