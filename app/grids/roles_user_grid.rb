class RolesUserGrid < WulinMaster::Grid
  title 'User roles'

  model RolesUser

  column :role, only: [:MasterUserDetailRoleScreen]
  column :user, source: 'email', only: [:MasterRoleDetailUserScreen]

  # actions for master sad detail role grid
  action :add_detail, model: 'role', screen: 'AddRoleForUserScreen', title: 'Add Roles', only: [:MasterUserDetailRoleScreen]

  # actions for master service detail sad grid
  action :add_detail, model: 'user', screen: 'AddUserForRoleScreen', title: 'Add Users', only: [:MasterRoleDetailUserScreen]

  # Common actions
  action :export
  action :delete
  action :audit
end
