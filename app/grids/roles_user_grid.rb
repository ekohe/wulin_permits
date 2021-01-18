class RolesUserGrid < WulinMaster::Grid
  title 'User roles'

  model RolesUser

  path "/roles_users"

  column :role, only: [:MasterUserDetailRoleScreen]
  column :user, source: 'email', only: [:MasterRoleDetailUserScreen]

  # actions for master sad detail role grid
  action :add_detail, model: 'role', screen: 'AddRoleForUserScreen', title: 'Attach Roles', only: [:MasterUserDetailRoleScreen]

  # actions for master service detail sad grid
  action :add_detail, model: 'user', screen: 'AddUserForRoleScreen', title: 'Attach Users', only: [:MasterRoleDetailUserScreen]

  # Common actions
  action :delete
  action :export
  action :audit
end
