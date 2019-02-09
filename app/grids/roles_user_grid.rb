class RolesUserGrid < WulinMaster::Grid
  title 'ユーザーロール'

  model RolesUser

  column :role, only: [:MasterUserDetailRoleScreen], label: '役割'
  column :user, source: 'email', only: [:MasterRoleDetailUserScreen]

  # actions for master sad detail role grid
  action :add_detail, model: 'role', screen: 'AddRoleForUserScreen', title: '役割追加', only: [:MasterUserDetailRoleScreen]

  # actions for master service detail sad grid
  action :add_detail, model: 'user', screen: 'AddUserForRoleScreen', title: '管理者追加', only: [:MasterRoleDetailUserScreen]

  # Common actions
  action :export, title: 'エクスポート'
  action :delete
  action :audit
  action :switch, title: '全ての役割', switch_to: { path: '/roles', screen: 'MasterRoleDetailUserScreen' }, only: [:MasterUserDetailRoleScreen]
  action :switch, title: '全てのユーザー', switch_to: { path: '/roles_users', screen: 'MasterUserDetailRoleScreen' }, only: [:MasterRoleDetailUserScreen]
end
