class UserGrid < WulinMaster::Grid
  title 'Users'

  model User

  path '/users'

  multi_select false

  cell_editable false

  column :email, :width => 500

  action :add_user, screen: 'AddUserScreen', model: 'user'
  action :export
  action :copy_grid_states, icon: :content_copy
end
