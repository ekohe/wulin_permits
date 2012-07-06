class UserGrid < WulinMaster::Grid
  title 'Users'

  model User
  
  fill_window

  multi_select false
  
  cell_editable false   

  column :email, :width => 500
  
  action :user_role, title: "Role", icon: 'user_role'
  action :filter
end