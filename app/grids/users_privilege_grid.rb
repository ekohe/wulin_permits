class UsersPrivilegeGrid < WulinMaster::Grid
  title "User privileges"

  model UsersPrivilege

  path "/users_privileges"

  column :name, through: :privilege, label: "Privilege", editable: false, only: [:MasterUserDetailPrivilegeScreen]

  if defined? Mima
    column :email, through: :user, label: "User", editable: false, only: [:MasterPrivilegeDetailUserScreen], formatter: "NullOverrideFormatter", value_to_replace_null: "Unknown User"
  else
    column :email, label: "User", sort_column: "mima_users.email", editable: false, only: [:MasterPrivilegeDetailUserScreen], formatter: "NullOverrideFormatter", value_to_replace_null: "Unknown User"
  end

  # actions for master user detail privilege grid
  action :add_detail, icon: :add_circle_outline, model: "privilege", screen: "AddPrivilegeForUserScreen", title: "Attach Privileges", only: [:MasterUserDetailPrivilegeScreen]
  action :delete, icon: :remove_circle_outline, title: "Remove Privileges", only: [:MasterUserDetailPrivilegeScreen]

  # actions for master privilege detail user grid
  action :add_detail, icon: :add_circle_outline, model: "user", screen: "AddUserForPrivilegeScreen", title: "Attach Users", only: [:MasterPrivilegeDetailUserScreen]
  action :delete, icon: :remove_circle_outline, title: "Remove Users", only: [:MasterPrivilegeDetailUserScreen]

  # Common actions
  action :export
  action :audit

  action(:audit) if defined? WulinAudit
end
