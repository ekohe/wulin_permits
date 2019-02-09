class MasterUserDetailRoleScreen < WulinMaster::Screen
  title 'ユーザーロール'

  path '/roles_users'

  grid UserGrid, width: '50%', height: '100%', css: 'position: absolute; bottom: 0; left: 0;'
  grid RolesUserGrid, width: '50%', height: '100%', css: 'position: absolute; bottom: 0; right: 0;', title: 'Roles with User', master_grid: 'UserGrid', eager_loading: false

  def authorized?(user)
    user.admin?
  end
end
