require "rails"
require 'wulin_permits/extensions/user'
require 'wulin_permits/extensions/screen_controller'
require 'wulin_permits/extensions/screen'

module WulinPermits
  class Engine < Rails::Engine
    initializer "include extensions to screen controller" do |app|
      User.send :include, WulinPermits::Extensions::User
      WulinMaster::ScreenController.send :include, WulinPermits::Extensions::ScreenController
      WulinMaster::Screen.send :include, WulinPermits::Extensions::Screen
    end
  end
end