class RolesUserGrid < WulinMaster::Grid
  title 'User roles'

  model RolesUser

  path "/roles_users"

  column :role, editable: false, only: [:MasterUserDetailRoleScreen]
  column :user, source: 'email', only: [:MasterRoleDetailUserScreen]

  # actions for master sad detail role grid
  action :add_detail, icon: :add_circle_outline, model: 'role', screen: 'AddRoleForUserScreen', title: 'Attach Roles', only: [:MasterUserDetailRoleScreen]
  action :delete, icon: :remove_circle_outline, title: 'Remove Roles', only: [:MasterUserDetailRoleScreen]

  # actions for master service detail sad grid
  action :add_detail, icon: :add_circle_outline, model: 'user', screen: 'AddUserForRoleScreen', title: 'Attach Users', only: [:MasterRoleDetailUserScreen]
  action :delete, icon: :remove_circle_outline, title: 'Remove Users', only: [:MasterRoleDetailUserScreen]

  # Common actions
  action :export
  action :audit

  action(:audit) if defined? WulinAudit
end
