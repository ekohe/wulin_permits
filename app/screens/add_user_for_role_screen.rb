class AddUserForRoleScreen < WulinMaster::Screen
  title "Available Users"

  grid UserGrid, title: 'Available Users', master_model: 'roles', multi_select: true

  def authorized?(user = nil)
    user ||= current_user
    return false if user.blank?

    user.has_permission_with_name?(WulinPermits::UserManagement::REVERSE_SCREEN_CUD)
  end
end
