class MasterPermissionRoleScreen < WulinMaster::Screen
  title 'Roles Permissions'

  path '/permissions'

  grid PermissionGrid, height: '100%', width: '50%', title: 'Permissions'
  grid PermissionsRoleGrid, height: '100%', width: '50%', title: 'Roles', master_grid: 'PermissionGrid', eager_loading: false

  def authorized?(user)
    user&.admin?
  end
end
