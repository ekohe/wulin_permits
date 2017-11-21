class RolesUserGrid < WulinMaster::Grid
  title 'User roles'

  model RolesUser

  column :role, only: [:MasterUserDetailRoleScreen]
  column :user, source: 'email', only: [:MasterRoleDetailUserScreen]

  # actions for master sad detail role grid
  action :add_detail, model: 'role', screen: 'AddRoleForUserScreen', title: 'Roles', only: [:MasterUserDetailRoleScreen]

  # actions for master service detail sad grid
  action :add_detail, model: 'user', screen: 'AddUserForRoleScreen', title: 'Users', only: [:MasterRoleDetailUserScreen]

  # Common actions
  action :export
  action :delete
  action :audit
  action :switch, title: 'All Roles', switch_to: { path: '/roles', screen: 'MasterRoleDetailUserScreen' }, only: [:MasterUserDetailRoleScreen]
  action :switch, title: 'All Users', switch_to: { path: '/roles_users', screen: 'MasterUserDetailRoleScreen' }, only: [:MasterRoleDetailUserScreen]
end
