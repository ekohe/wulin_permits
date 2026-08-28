class RolesUserGrid < WulinMaster::Grid
  title "User roles"

  model RolesUser

  path "/roles_users"

  column :name, through: :role, label: "Role", editable: false, only: [:MasterUserDetailRoleScreen]

  if defined? Mima
    column :email, through: :user, label: "User", editable: false, only: [:MasterRoleDetailUserScreen], formatter: "NullOverrideFormatter", value_to_replace_null: "Unknown User"
  else
    column :email, label: "User", sort_column: "mima_users.email", editable: false, only: [:MasterRoleDetailUserScreen], formatter: "NullOverrideFormatter", value_to_replace_null: "Unknown User"
  end

  # actions for master sad detail role grid
  action :add_detail, icon: :add_circle_outline, model: "role", screen: "AddRoleForUserScreen", title: "Attach Roles", only: [:MasterUserDetailRoleScreen],
    authorized?: ->(user) { user.has_permission_with_name?(WulinPermits::UserManagement::SCREEN_CUD) }
  action :delete, icon: :remove_circle_outline, title: "Remove Roles", only: [:MasterUserDetailRoleScreen],
    authorized?: ->(user) { user.has_permission_with_name?(WulinPermits::UserManagement::SCREEN_CUD) }

  # actions for master service detail sad grid
  action :add_detail, icon: :add_circle_outline, model: "user", screen: "AddUserForRoleScreen", title: "Attach Users", only: [:MasterRoleDetailUserScreen],
    authorized?: ->(user) { user.has_permission_with_name?(WulinPermits::UserManagement::REVERSE_SCREEN_CUD) }
  action :delete, icon: :remove_circle_outline, title: "Remove Users", only: [:MasterRoleDetailUserScreen],
    authorized?: ->(user) { user.has_permission_with_name?(WulinPermits::UserManagement::REVERSE_SCREEN_CUD) }

  # Common actions
  action :export
  action :audit

  action(:audit) if defined? WulinAudit
end
