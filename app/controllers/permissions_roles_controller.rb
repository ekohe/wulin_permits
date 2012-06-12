class PermissionsRolesController < WulinMaster::ScreenController
  controller_for_screen PermissionsRoleScreen

  add_callback :query_ready, :include_filter
  
  def include_filter
    if params[:unavailable].to_s == 'true' and params[:role_id].present? and params[:filters].blank?
      @query = @query.where(role_id: params[:role_id])
    end
  end
end