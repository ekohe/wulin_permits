class PermissionsController < WulinMaster::ScreenController
  controller_for_screen PermissionScreen

  add_callback :query_ready, :exclude_filter
  
  def exclude_filter
    if params[:available].to_s == 'true' and params[:role_id].present?
      permission_ids = PermissionsRole.where(role_id: params[:role_id]).pluck(:permission_id)
      @query = @query.where('id NOT IN (?)', permission_ids) if permission_ids.present?
    end
  end
end