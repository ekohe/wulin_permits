class UserGrid < WulinMaster::Grid
  title 'Users'

  model User

  path '/users'

  multi_select false

  cell_editable false

  column :email, :width => 500

  action :export
end
