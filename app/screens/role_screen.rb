class RoleScreen < WulinMaster::Screen
  title 'Roles'

  path '/roles'

  grid RoleGrid, height: '50%'

  def authorized?(user)
    user.admin?
  end
  
end