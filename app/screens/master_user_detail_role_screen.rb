class MasterUserDetailRoleScreen < WulinMaster::Screen
  title 'Users Roles'

  path '/roles_users'
  
  grid UserGrid, width: '47%', height: '100%', css: 'position: absolute; bottom: 0; left: 0;'
  panel CarouselSwitchPanel, width: '6%', height: '100%', css: 'position: absolute; bottom: 0; left: 47%;', next_screen: 'MasterRoleDetailUserScreen'
  grid RolesUserGrid, width: '47%', height: '100%', css: 'position: absolute; bottom: 0; right: 0;', title: 'Roles with User', master_grid: 'UserGrid', eager_loading: false
end