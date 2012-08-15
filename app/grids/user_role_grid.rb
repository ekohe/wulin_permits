class UserRoleGrid < WulinMaster::Grid
  title 'User roles'

  model UserRole
  
  hide_header
  
  column :roler_name, :width => 200
end