class AddRoleForUserScreen < WulinMaster::Screen
  title "Available Roles"

  grid RoleGrid, title: 'Available Roles', master_model: 'users'

  def authorized?(user = nil)
    user ||= current_user
    return false if user.blank?

    user.has_permission_with_name?(WulinPermits::UserManagement::SCREEN_CUD)
  end
end
