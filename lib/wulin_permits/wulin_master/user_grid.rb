class UserGrid < WulinMaster::Grid
  title 'Users'

  model User
  
  fill_window
  
  path '/users'    

  column :email, :width => 500, :editable => false
  
  action :filter
end