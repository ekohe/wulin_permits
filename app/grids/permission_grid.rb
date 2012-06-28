class PermissionGrid < WulinMaster::Grid
  title 'Permissions'

  model Permission
  
  cell_editable false
  
  action :filter 

  column :name, label: 'Permission'
  column :roles, visible: false, editable: false, option_text_attribute: "id", only: [:RoleScreen]   # neccessary for exclusion relation
end