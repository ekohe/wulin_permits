class UserAllPermissionsController < WulinMaster::ScreenController
  before_action :require_admin
  controller_for_screen MasterUserDetailPermissionScreen
end
