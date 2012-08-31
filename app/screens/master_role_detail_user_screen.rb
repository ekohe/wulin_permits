class MasterRoleDetailUserScreen < WulinMaster::Screen
  path '/roles'
  
  grid RoleGrid, width: '47%', height: '100%', css: 'position: absolute; bottom: 0; left: 0;'
  panel CarouselSwitchPanel, width: '6%', height: '100%', css: 'position: absolute; bottom: 0; left: 47%;', next_screen: 'MasterUserDetailRoleScreen'
  grid RolesUserGrid, width: '47%', height: '100%', css: 'position: absolute; bottom: 0; right: 0;', title: 'Users for Role', master_grid: 'RoleGrid', eager_loading: false
end