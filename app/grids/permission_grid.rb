class PermissionGrid < WulinMaster::Grid
  title 'Permissions'

  model Permission
  
  action :filter
  action :delete, only: [:PermissionScreen]

  column :name, label: 'Permission', editable: false
  column :description, width: 300
end