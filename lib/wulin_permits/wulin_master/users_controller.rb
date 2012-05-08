class UsersController < WulinMaster::ScreenController
  before_filter :require_admin
  controller_for_screen UserScreen
  controller_for_grid UserGrid
  
  add_callback :query_ready, :set_request_uri
  
  protected
  
  # The request URI is passed to query the account management application
  def set_request_uri
    @query = @query.set_request_uri(request.fullpath)
  end
end