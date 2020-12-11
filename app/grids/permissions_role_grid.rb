class PermissionsRoleGrid < WulinMaster::Grid
  title "Permissions Roles"

  model PermissionsRole

  path "/permissions_roles"

  column :permission, editable: false
  column :description, sql_expression: "#{Permission.table_name}.description"
end
