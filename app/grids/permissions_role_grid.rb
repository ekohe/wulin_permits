class PermissionsRoleGrid < WulinMaster::Grid
  title 'Permissions Roles'

  model PermissionsRole

  column :permission, editable: false, label: 'パーミッション'
  column :description, sql_expression: 'permissions.description', label: '内容'
end
