class PermissionsController < WulinMaster::ScreenController
  before_filter :delete_roles_param, only: :update

  def delete_roles_param
    params[:item].delete(:roles)
  end
end