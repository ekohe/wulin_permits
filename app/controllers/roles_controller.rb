class RolesController < WulinMaster::ScreenController
  controller_for_screen RoleScreen
  
  def update_permission
    if (ids = params[:ids].split(',')).present? and params[:type].present? and Role.exists?(params[:role_id])
      if params[:type] == 'add'
        PermissionsRole.transaction do
          ids.each do |permission_id|
            PermissionsRole.create!(role_id: params[:role_id], permission_id: permission_id)
          end
        end
      elsif params[:type] == 'remove'
        PermissionsRole.where('id IN (?)', ids).destroy_all
      end
    end
    render text: 'OK'
  rescue
    render text: "Update permission failed! Error: #{$!.message}"
  end

end