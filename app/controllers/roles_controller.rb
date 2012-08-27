class RolesController < WulinMaster::ScreenController
  controller_for_screen RoleScreen
  
  add_callback :query_ready, :filter_for_user
  
  # protected
  
  def filter_for_user
    user_filter_params = params[:filters].to_a.find{|x| x.values.include?("user_id") and x.values.include?("exclude")}
    return if user_filter_params.blank?

    role_ids = RolesUser.where(:user_id => user_filter_params[:value]).pluck(:role_id).uniq
    
    @query = grid.model
    @query = grid.model.where("id NOT IN (?)", role_ids) if role_ids.present?
  end
end