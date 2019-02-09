class PermissionGrid < WulinMaster::Grid
  title 'Permissions'

  model Permission

  path '/permissions'

  action :delete, only: [:PermissionScreen]

  column :name, label: 'パーミッション', editable: false
  column :description, width: 300, label: '内容'
end
