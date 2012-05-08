class UserGrid < WulinMaster::Grid
  title 'Users'

  model User
  
  fill_window
  
  path '/users'    
  set_actions :filter

  column :email, :width => 500, :editable => false
end