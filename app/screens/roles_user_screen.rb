class RolesUserScreen < WulinMaster::Screen
  title 'User roles'

  path '/roles_users'

  grid RolesUserGrid, width: '500px', height: '250px'

  def authorized?(user = nil)
    user ||= current_user
    return false if user.blank?

    user.has_permission_with_name?(WulinPermits::UserManagement::SCREEN_READ)
  end
end
