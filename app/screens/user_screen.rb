class UserScreen < WulinMaster::Screen
  title 'Users'

  path '/users'

  grid UserGrid

  def authorized?(user = nil)
    user ||= current_user
    return false if user.blank?

    user.has_permission_with_name?(WulinPermits::UserManagement::SCREEN_READ) ||
      user.has_permission_with_name?(WulinPermits::UserManagement::INVITE)
  end
end
