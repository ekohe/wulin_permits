class RoleGrid < WulinMaster::Grid
  title 'Roles'

  model Role

  column :name
  
  # load_default_actions
  # Common actions
  action :filter
  action :excel
  action :audit
end