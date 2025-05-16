class PermissionGrid < WulinMaster::Grid
  title "権限"

  model Permission

  path "/permissions"

  action :delete, only: [:PermissionScreen]
  action(:audit) if defined? WulinAudit

  column :permission_grid_name,
    label: "権限",
    sql_expression: "#{Permission.table_name}.name",
    editable: false

  column :permission_grid_description,
    label: "説明",
    sql_expression: "#{Permission.table_name}.description",
    width: 300
end
