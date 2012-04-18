class UserRoleScreen < WulinMaster::Screen
  title 'User roles'

  path '/user_roles'

  grid UserRoleGrid
  
  def authorized?(user)
    user.admin?
  end
end