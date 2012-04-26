class PermissionsRoleScreen < WulinMaster::Screen
  title 'Permissions Roles'

  path '/permissions_roles'

  grid PermissionsRoleGrid
  
  def authorized?(user)
    user.admin?
  end
  
end