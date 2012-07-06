class UserRoleScreen < WulinMaster::Screen
  title 'User roles'

  path '/user_roles'

  grid UserRoleGrid, width: '500px', height: '250px'
  
  def authorized?(user)
    user.admin?
  end
end