class RoleScreen < WulinMaster::Screen
  title 'ロール権限'

  path '/roles'

  grid RoleGrid, height: '100%', width: '50%', title: 'ロール'
  grid PermissionsRoleGrid, height: '100%', width: '50%', title: '既存の権限', master_grid: 'RoleGrid', eager_loading: false

  def authorized?(user)
    user&.admin?
  end
end
