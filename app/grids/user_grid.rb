class UserGrid < WulinMaster::Grid
  title 'ユーザー'

  model User

  path '/users'

  multi_select false

  cell_editable false

  column :email, width: 250
  column :password, visible: false, formable: %i[new edit], password: true
  column :created_at, formable: false
  column :updated_at, formable: false, visible: false

  load_default_actions
  action :copy_grid_states, icon: :content_copy, title: 'Copy Grid States', only: [:GridStatesScreen]
end
