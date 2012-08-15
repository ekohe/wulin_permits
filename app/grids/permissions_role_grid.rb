class PermissionsRoleGrid < WulinMaster::Grid
  title 'Permissions Roles'

  model PermissionsRole
  
  cell_editable false
  
  action :filter

  column :permission
end