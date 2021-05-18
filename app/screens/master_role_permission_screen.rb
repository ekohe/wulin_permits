class MasterRolePermissionScreen < WulinMaster::Screen
  title 'Roles Permissions'

  path '/roles'

  grid RoleGrid, height: '100%', width: '50%', title: 'Role'
  grid PermissionsRoleGrid, height: '100%', width: '50%', title: 'Existing permissions', master_grid: 'RoleGrid', eager_loading: false

  def authorized?(user)
    user&.admin?
  end
end
