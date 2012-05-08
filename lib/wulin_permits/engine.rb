require "rails"
require 'wulin_permits/extensions/user'
require 'wulin_permits/extensions/screen_controller'
require 'wulin_permits/extensions/screen'


module WulinPermits
  class Engine < Rails::Engine
    initializer "Load extensions and definations" do |app|
      User.send :include, WulinPermits::Extensions::User
      WulinMaster::ScreenController.send :include, WulinPermits::Extensions::ScreenController
      WulinMaster::Screen.send :include, WulinPermits::Extensions::Screen
      
      require 'wulin_permits/wulin_master/user_grid' unless defined? UserGrid
      require 'wulin_permits/wulin_master/user_screen' unless defined? UserScreen
      require 'wulin_permits/wulin_master/users_controller' unless defined? UsersController
    end
  end
end