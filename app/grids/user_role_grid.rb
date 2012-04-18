class UserRoleGrid < WulinMaster::Grid
  title 'User roles'

  model UserRole

  path '/user_roles'
  
  fill_window

  # width '400px'
  # height '160px'

  column :human_role, :width => 200
end