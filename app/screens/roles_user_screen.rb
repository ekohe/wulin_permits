class RolesUserScreen < WulinMaster::Screen
  title 'User roles'

  path '/roles_users'

  grid RolesUserGrid, width: '500px', height: '250px'
  
  def authorized?(user)
    user.admin?
  end
end