class UserAllPermissionGrid < WulinMaster::Grid
  title "User permissions"

  model UserAllPermission

  path "/user_all_permissions"

  cell_editable false

  # This is needed for master-detail relationship to work with the view
  column :user_id, visible: false

  column :permission_name, label: "Permission", width: 250
  column :permission_description, label: "Description", width: 300
  column :source_type, label: "Source Type", width: 100
  column :source_name, label: "Source Name", width: 200

  action :export
  action(:audit) if defined? WulinAudit
end