class UsersController < WulinMaster::ScreenController
  before_action :require_admin
  controller_for_screen UserScreen

  add_callback :query_ready, :set_request_uri
  add_callback :query_ready, :load_uninvited_users
  add_callback :objects_ready, :filter_for_role

  def invite
    invite_result = User.invite(params[:user_ids])
    render json: { message: invite_result["message"] }
  end

  protected

  # The request URI is passed to query the account management application
  def set_request_uri
    @query = @query.set_request_uri(request.fullpath.sub(/screen=[A-Za-z]*/,'screen=UsersScreen')) if @query.respond_to?(:set_request_uri)
  end

  # load all users including uninvited uses
  def load_uninvited_users
    if params[:uninvited_users_only] == 'true'
      @query = @query.to_a(invited: false)
      params[:count] = 20000
    end
  end

  def filter_for_role
    role_filter_params = params[:filters].to_a.find{|x| x.values.include?("role_id") and x.values.include?("exclude")}
    return if role_filter_params.blank?

    user_ids = RolesUser.where(:role_id => role_filter_params[:value]).pluck(:user_id).uniq

    @objects = User.all

    @objects.reject!{|x| user_ids.include?(x.id.to_i)} if user_ids.present?
    @count = @objects.size
  end
end
