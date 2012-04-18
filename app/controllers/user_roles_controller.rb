class UserRolesController < WulinMaster::ScreenController
  before_filter :require_admin

  controller_for_screen UserRoleScreen
  controller_for_grid UserRoleGrid

  add_callback :query_ready, :set_user_id_condition
  
  protected
  
  def set_user_id_condition
    return if params[:user_id].nil?
    
    @user_id = params[:user_id].to_i
    @query = @query.where(:user_id => params[:user_id].to_i)
  end
end