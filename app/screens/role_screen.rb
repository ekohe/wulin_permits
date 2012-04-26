class RoleScreen < WulinMaster::Screen
  title 'Roles'

  path '/roles'

  grid RoleGrid

  def authorized?(user)
    user.admin?
  end
  
end