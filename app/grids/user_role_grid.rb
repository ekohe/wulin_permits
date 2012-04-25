class UserRoleGrid < WulinMaster::Grid
  title 'User roles'

  model UserRole

  path '/user_roles'
  
  width '500px'
  height '250px'
  
  hide_header
  
  column :user_id, visible: false
  column :roler_name, :width => 200
  
end