class RolesUsersController < WulinMaster::ScreenController
  before_filter :require_admin

  controller_for_screen MasterUserDetailRoleScreen

  add_callback :query_ready, :set_user_id_condition
  add_callback :query_ready, :set_role_id_condition
  
  protected
  
  def set_user_id_condition
    user_filter_params = params[:filters].find{|x| x.values.include?("user_id")}
    return if user_filter_params.blank?
    
    @query = grid.model.where(:user_id => user_filter_params[:value])
  end
  
  def set_role_id_condition
    role_filter_params = params[:filters].find{|x| x.values.include?("role_id")}
    return if role_filter_params.blank?
    @query = grid.model.where(:role_id => role_filter_params[:value])
  end
end