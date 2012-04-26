class PermissionScreen < WulinMaster::Screen
  title 'Permissions'

  path '/permissions'

  grid PermissionGrid
  
  def authorized?(user)
    user.admin?
  end
  
end