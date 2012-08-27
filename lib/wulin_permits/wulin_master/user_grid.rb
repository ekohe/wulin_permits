class UserGrid < WulinMaster::Grid
  title 'Users'

  model User
  
  # fill_window

  multi_select false
  
  cell_editable false   

  column :email, :width => 500
  
  # action :roles_user, title: "Role", icon: 'roles_user'
  action :filter
  action :excel
end