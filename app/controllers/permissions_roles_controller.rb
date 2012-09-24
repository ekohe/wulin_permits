class PermissionsRolesController < WulinMaster::ScreenController
  before_filter :keep_permission_description_only, only: :update

  def keep_permission_description_only
    params[:item].delete(:permission)
    params[:item].delete(:role)
  end
end