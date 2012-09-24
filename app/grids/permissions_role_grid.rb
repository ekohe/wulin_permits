class PermissionsRoleGrid < WulinMaster::Grid
  title 'Permissions Roles'

  model PermissionsRole
  
  action :filter

  column :permission, editable: false
  column :description, sql_expression: 'permissions.description'
end