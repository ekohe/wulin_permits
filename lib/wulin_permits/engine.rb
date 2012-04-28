require "rails"
require 'wulin_permits/extensions/user'
require 'wulin_permits/extensions/screen_controller'

module WulinPermits
  class Engine < Rails::Engine
    initializer "include extensions to screen controller" do |app|
      User.send :include, WulinPermits::Extensions::User
      WulinMaster::ScreenController.send :include, WulinPermits::Extensions::ScreenController
    end
  end
end