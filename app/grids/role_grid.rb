class RoleGrid < WulinMaster::Grid
  title 'Roles'

  model Role

  path '/roles'

  column :name
  column :description

  load_default_actions({only: [:MasterRoleDetailUserScreen]})

  action :export_role_permission, title: 'Export Role Permission', icon: :file_download, only: [:RoleScreen]
  action :import_role_permission, title: 'Import Role Permission', icon: :file_upload, global: true, only: [:RoleScreen]
  action :create, only: [:RoleScreen]
  action :delete, only: [:RoleScreen]

  action(:audit) if defined? WulinAudit
end
