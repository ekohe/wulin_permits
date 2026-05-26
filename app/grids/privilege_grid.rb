class PrivilegeGrid < WulinMaster::Grid
  title "Privileges"

  model Privilege

  path "/privileges"

  column :name
  column :description, width: 300
  column :user_id, through: :users_privileges, source: :user_id, visible: false, editable: false, formable: false, only: [:AddPrivilegeForUserScreen]

  load_default_actions({only: [:MasterRolePrivilegeScreen, :MasterPrivilegeRoleScreen]})

  action :export_privilege_permission, title: 'Export Privilege Permission', icon: :file_download, only: [:PrivilegeScreen]
  action :import_privilege_permission, title: 'Import Privilege Permission', icon: :file_upload, global: true, only: [:PrivilegeScreen]

  action :create, only: [:PrivilegeScreen]
  action :delete, only: [:PrivilegeScreen]

  action(:audit) if defined? WulinAudit
end
