class MasterPermissionRoleScreen < WulinMaster::Screen
  title 'ロール権限'

  path '/permissions'

  grid PermissionGrid, height: '100%', width: '50%', title: '権限一覧'
  grid PermissionsRoleGrid, height: '100%', width: '50%', title: 'ロール一覧', master_grid: 'PermissionGrid', eager_loading: false

  def authorized?(user)
    user&.admin?
  end
end
