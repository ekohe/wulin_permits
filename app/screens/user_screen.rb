class UserScreen < WulinMaster::Screen
  title 'ユーザー'

  path '/users'

  grid UserGrid

  def authorized?(user)
    user.admin?
  end
end
