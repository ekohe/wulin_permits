class RolesUserGrid < WulinMaster::Grid
  title "ユーザーロール"

  model RolesUser

  path "/roles_users"

  column :name, through: :role, label: "Role", editable: false, only: [:MasterUserDetailRoleScreen]
  column :email, label: "User", editable: false, only: [:MasterRoleDetailUserScreen], formatter: "NullOverrideFormatter", value_to_replace_null: "Unknown User"

  # actions for master sad detail role grid
  action :add_detail, icon: :add_circle_outline, model: "role", screen: "AddRoleForUserScreen", title: "ロールを追加", only: [:MasterUserDetailRoleScreen]
  action :delete, icon: :remove_circle_outline, title: "ロールを削除", only: [:MasterUserDetailRoleScreen]

  # actions for master service detail sad grid
  action :add_detail, icon: :add_circle_outline, model: "user", screen: "AddUserForRoleScreen", title: "ユーザーを追加", only: [:MasterRoleDetailUserScreen]
  action :delete, icon: :remove_circle_outline, title: "ユーザーを削除", only: [:MasterRoleDetailUserScreen]

  # Common actions
  action :export
  action :audit

  action(:audit) if defined? WulinAudit
end
