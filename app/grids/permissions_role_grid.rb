class PermissionsRoleGrid < WulinMaster::Grid
  title 'Permissions Roles'

  model PermissionsRole

  column :permission, editable: false
  column :description, sql_expression: 'permissions.description'
end
