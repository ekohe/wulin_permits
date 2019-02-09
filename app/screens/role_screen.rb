class RoleScreen < WulinMaster::Screen
  title '役割ごとのパーミッション'

  path '/roles'

  grid RoleGrid, height: '50%'

  grid PermissionsRoleGrid, height: '50%', width: '45%', title: '既存のパーミッション', include_of: "RoleGrid", eager_loading: false
  panel WulinMaster::InclusionExclusionPanel, height: '50%', width: '10%', inclusion_grid: 'PermissionsRoleGrid', exclusion_grid: 'PermissionGrid'
  grid PermissionGrid, height: '50%', width: '45%', title: '利用可能なパーミッション', exclude_of: "RoleGrid", eager_loading: false

  def authorized?(user)
    user.admin?
  end
end