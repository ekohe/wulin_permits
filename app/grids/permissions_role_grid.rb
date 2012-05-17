class PermissionsRoleGrid < WulinMaster::Grid
  title 'Permissions Roles'

  model PermissionsRole

  path '/permissions_roles' 
  
  set_actions :filter

  fill_window
  
  column :role_id, visible: false
  column :permission
  
  def unavailable?
    controller.request.params[:unavailable].to_s == 'true'
  end
  
  def name
    if unavailable?
      'unavailable_permission'
    else
      super
    end
  end
  
  def style
    if unavailable?
      "height: 50%; width: 100%;"
    else
      super
    end
  end
  
end