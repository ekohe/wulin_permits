class RolesUserGrid < WulinMaster::Grid
  title 'User roles'

  model RolesUser
  
  column :role, only: [:MasterUserDetailRoleScreen]
  column :user, option_text_attribute: 'email', only: [:MasterRoleDetailUserScreen]
  
  # actions for master sad detail role grid
  action :add_detail, model: 'role', screen: 'AddRoleForUserScreen', title: 'Add Roles', icon: 'add', only: [:MasterUserDetailRoleScreen]
  action :delete, title: 'Remove Roles', only: [:MasterUserDetailRoleScreen]

  # actions for master service detail sad grid
  action :add_detail, model: 'user', screen: 'AddUserForRoleScreen', title: 'Add Users', icon: 'add', only: [:MasterRoleDetailUserScreen]
  action :delete, title: 'Remove Users', only: [:MasterRoleDetailUserScreen]
  
  # Common actions
  action :filter
  action :excel
  action :audit
end