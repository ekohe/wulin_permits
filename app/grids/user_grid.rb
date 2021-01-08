class UserGrid < WulinMaster::Grid
  title 'Users'

  model User

  path '/users'

  multi_select false

  cell_editable false

  column :email, width: 250

  action :export
  action :copy_grid_states, icon: :content_copy, title: 'Copy Grid States', only: [:GridStatesScreen]
end
