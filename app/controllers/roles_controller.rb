# frozen_string_literal: true

class RolesController < WulinMaster::ScreenController
  controller_for_screen RoleScreen

  private

  def setup_missing_permission
    if params[:screen].to_s == "AddRoleForUserScreen"
      create_permission(WulinPermits::UserManagement::SCREEN_CUD)
    else
      super
    end
  end
end
