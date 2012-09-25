class RolesUserGrid < WulinMaster::Grid
  title 'User roles'

  model RolesUser
  
  column :role, only: [:MasterUserDetailRoleScreen]
  column :user, option_text_attribute: 'email', only: [:MasterRoleDetailUserScreen]
  
  # actions for master sad detail role grid
  action :add_detail, model: 'role', screen: 'AddRoleForUserScreen', title: 'Add Roles', icon: 'link', only: [:MasterUserDetailRoleScreen]
  action :delete, title: 'Remove Roles', icon: 'unlink', only: [:MasterUserDetailRoleScreen]

  # actions for master service detail sad grid
  action :add_detail, model: 'user', screen: 'AddUserForRoleScreen', title: 'Add Users', icon: 'link', only: [:MasterRoleDetailUserScreen]
  action :delete, title: 'Remove Users', icon: 'unlink', only: [:MasterRoleDetailUserScreen]
  
  # Common actions
  # action :filter
  action :excel
  action :audit
end