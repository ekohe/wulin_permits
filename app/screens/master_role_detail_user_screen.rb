class MasterRoleDetailUserScreen < WulinMaster::Screen
  path '/roles'

  grid RoleGrid, width: '47%', height: '100%', css: 'position: absolute; bottom: 0; left: 0;'
  grid RolesUserGrid, width: '53%', height: '100%', css: 'position: absolute; bottom: 0; right: 0;', title: 'Users for Role', master_grid: 'RoleGrid', eager_loading: false
end
