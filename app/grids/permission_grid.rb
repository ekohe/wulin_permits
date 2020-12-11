class PermissionGrid < WulinMaster::Grid
  title "Permissions"

  model Permission

  path "/permissions"

  action :delete, only: [:PermissionScreen]

  column :permission_grid_name,
    label: "Permission",
    sql_expression: "#{Permission.table_name}.name",
    editable: false

  column :permission_grid_description,
    label: "Description",
    sql_expression: "#{Permission.table_name}.description",
    width: 300
end
