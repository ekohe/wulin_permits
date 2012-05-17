class RoleGrid < WulinMaster::Grid
  title 'Roles'

  model Role

  path '/roles' 

  width '100%'
  height '50%'

  column :name
  
  load_default_actions
end