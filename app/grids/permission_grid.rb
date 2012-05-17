class PermissionGrid < WulinMaster::Grid
  title 'Permissions'

  model Permission

  path '/permissions'
  
  set_actions :filter 

  fill_window

  column :name, label: 'Permission'

  def available?
    controller.request.params[:available].to_s == 'true'
  end
  
  def name
    if available?
      'available_permission'
    else
      super
    end
  end
  
  def style
    if available?
      "height: 50%; width: 100%;"
    else
      super
    end
  end
  
end