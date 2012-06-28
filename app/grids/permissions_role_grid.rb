class PermissionsRoleGrid < WulinMaster::Grid
  title 'Permissions Roles'

  model PermissionsRole
  
  cell_editable false
  
  action :filter

  column :role_id, visible: false   # neccessary for inclusion relation
  column :permission
end