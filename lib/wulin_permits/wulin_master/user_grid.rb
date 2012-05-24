class UserGrid < WulinMaster::Grid
  title 'Users'

  model User
  
  fill_window
  
  path '/users' 

  cell_editable false   

  column :email, :width => 500
  
  action :filter
end