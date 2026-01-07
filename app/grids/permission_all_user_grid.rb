class PermissionAllUserGrid < WulinMaster::Grid
  title "Users with Permission"

  model PermissionAllUser

  path "/permission_all_users"

  cell_editable false

  # This is needed for master-detail relationship to work with the view
  column :permission_id, visible: false

  column :email, label: "User Email", width: 250
  column :source_type, label: "Source Type", width: 100
  column :source_name, label: "Source Name", width: 200

  action :export
  action(:audit) if defined? WulinAudit
end
