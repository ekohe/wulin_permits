class UserGrid < WulinMaster::Grid
  title 'Users'

  model User

  multi_select false
  
  cell_editable false

  column :email, :width => 500
  
  action :filter
  action :excel
end