class UserScreen < WulinMaster::Screen
  title 'Users'

  path '/users'

  grid UserGrid
  
  def authorized?(user)
    user.admin?
  end
end