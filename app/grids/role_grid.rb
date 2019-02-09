class RoleGrid < WulinMaster::Grid
  title '役割'

  model Role

  column :name, label: '名前'

  load_default_actions({only: [:MasterRoleDetailUserScreen]})

  action :create, only: [:RoleScreen]
  action :delete, only: [:RoleScreen]
end
