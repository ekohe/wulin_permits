# frozen_string_literal: true

class RoleScreen < WulinMaster::Screen
  title 'Roles Permissions'

  path '/roles'

  grid RoleGrid, height: '50%'

  grid PermissionsRoleGrid, height: '50%', width: '45%', title: 'Existing permissions', include_of: "RoleGrid", eager_loading: false
  panel WulinMaster::InclusionExclusionPanel, height: '50%', width: '10%', inclusion_grid: 'PermissionsRoleGrid', exclusion_grid: 'PermissionGrid'
  grid PermissionGrid, height: '50%', width: '45%', title: 'Available permissions', exclude_of: "RoleGrid", eager_loading: false

  def authorized?(user)
    user&.admin?
  end
end
