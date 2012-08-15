class PermissionGrid < WulinMaster::Grid
  title 'Permissions'

  model Permission
  
  cell_editable false
  
  action :filter
  action :delete, only: [:PermissionScreen]

  column :name, label: 'Permission'
end